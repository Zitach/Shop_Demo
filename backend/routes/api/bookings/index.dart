import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/middleware/error_handler.dart';
import '../../../lib/services/auth_service.dart';
import '../../../lib/services/booking_service.dart';

/// Extract and verify userId from Authorization header
String? _getUserId(RequestContext context) {
  final authHeader = context.request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) return null;
  final token = authHeader.substring(7);
  return context.read<AuthService>().verifyToken(token);
}

/// POST /api/bookings
/// Create a new booking (auth required)
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
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
  final body = await context.request.json() as Map<String, dynamic>;

  final listingId = body['listingId'] as String?;
  final checkInStr = body['checkIn'] as String?;
  final checkOutStr = body['checkOut'] as String?;
  final guests = body['guests'] as int?;
  final totalPrice = (body['totalPrice'] as num?)?.toDouble();
  final specialRequests = body['specialRequests'] as String?;

  // Validate required fields
  if (listingId == null || checkInStr == null || checkOutStr == null || guests == null || totalPrice == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'listingId, checkIn, checkOut, guests, and totalPrice are required',
        }
      },
    );
  }

  final checkIn = DateTime.tryParse(checkInStr);
  final checkOut = DateTime.tryParse(checkOutStr);

  if (checkIn == null || checkOut == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Invalid date format. Use ISO 8601 format.',
        }
      },
    );
  }

  try {
    final booking = await bookingService.create(
      listingId: listingId,
      userId: userId,
      checkIn: checkIn,
      checkOut: checkOut,
      guests: guests,
      totalPrice: totalPrice,
      specialRequests: specialRequests,
    );

    return Response.json(
      statusCode: HttpStatus.created,
      body: {
        'booking': _bookingToJson(booking),
      },
    );
  } on AppHttpException catch (e) {
    return Response.json(
      statusCode: e.statusCode,
      body: {
        'error': {
          'code': e.statusCode,
          'message': e.message,
        }
      },
    );
  }
}

Map<String, dynamic> _bookingToJson(dynamic b) => {
      'id': b.id,
      'listingId': b.listingId,
      'guestId': b.guestId,
      'hostId': b.hostId,
      'startDate': b.startDate.toIso8601String(),
      'endDate': b.endDate.toIso8601String(),
      'numGuests': b.numGuests,
      'totalPrice': b.totalPrice,
      'currency': b.currency,
      'status': b.status,
      'specialRequests': b.specialRequests,
      'cancelledAt': b.cancelledAt?.toIso8601String(),
      'cancellationReason': b.cancellationReason,
      'createdAt': b.createdAt.toIso8601String(),
      'updatedAt': b.updatedAt.toIso8601String(),
    };
