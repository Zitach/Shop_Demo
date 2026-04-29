import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/services/auth_service.dart';
import '../../../lib/services/booking_service.dart';

/// Extract and verify userId from Authorization header
String? _getUserId(RequestContext context) {
  final authHeader = context.request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) return null;
  final token = authHeader.substring(7);
  return context.read<AuthService>().verifyToken(token);
}

/// GET /api/bookings/:id
/// Get booking by ID (auth required, only own bookings)
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final userId = _getUserId(context);
  if (userId == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Authentication required',
        }
      },
    );
  }

  final bookingService = context.read<BookingService>();
  final booking = await bookingService.getById(id);

  if (booking == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {
        'error': {
          'code': HttpStatus.notFound,
          'message': 'Booking not found',
        }
      },
    );
  }

  // Only allow guest or host to view the booking
  if (booking.guestId != userId && booking.hostId != userId) {
    return Response.json(
      statusCode: HttpStatus.forbidden,
      body: {
        'error': {
          'code': HttpStatus.forbidden,
          'message': 'Not authorized to view this booking',
        }
      },
    );
  }

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'booking': {
        'id': booking.id,
        'listingId': booking.listingId,
        'guestId': booking.guestId,
        'hostId': booking.hostId,
        'startDate': booking.startDate.toIso8601String(),
        'endDate': booking.endDate.toIso8601String(),
        'numGuests': booking.numGuests,
        'totalPrice': booking.totalPrice,
        'currency': booking.currency,
        'status': booking.status,
        'specialRequests': booking.specialRequests,
        'cancelledAt': booking.cancelledAt?.toIso8601String(),
        'cancellationReason': booking.cancellationReason,
        'createdAt': booking.createdAt.toIso8601String(),
        'updatedAt': booking.updatedAt.toIso8601String(),
      },
    },
  );
}
