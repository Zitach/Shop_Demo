// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shop Demo';

  @override
  String get appName => 'Shop Demo';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get searchWhere => 'Where';

  @override
  String get searchWhen => 'When';

  @override
  String get searchWho => 'Who';

  @override
  String get searchAnywhere => 'Anywhere';

  @override
  String get searchAnyWeek => 'Any week';

  @override
  String get searchAddGuests => 'Add guests';

  @override
  String get searchButton => 'Search';

  @override
  String get categoryNew => 'NEW';

  @override
  String get guestFavorite => 'Guest favorite';

  @override
  String perNight(String price) {
    return '$price night';
  }

  @override
  String reviewCount(int count) {
    return '$count reviews';
  }

  @override
  String listingHosted(String hostName) {
    return 'Hosted by $hostName';
  }

  @override
  String get superhost => 'Superhost';

  @override
  String hostingYears(int count) {
    return '$count years hosting';
  }

  @override
  String responseRate(int rate) {
    return '$rate% response rate';
  }

  @override
  String get contactHost => 'Contact host';

  @override
  String showAllAmenities(int count) {
    return 'Show all $count amenities';
  }

  @override
  String get whatThisPlaceOffers => 'What this place offers';

  @override
  String get guestFavoriteTitle => 'Guest favorite';

  @override
  String get guestFavoriteSubtitle => 'One of the most loved homes on Airbnb';

  @override
  String get showMore => 'Show more';

  @override
  String reviewsTitle(int count) {
    return '$count reviews';
  }

  @override
  String get reserve => 'Reserve';

  @override
  String get addDates => 'Add dates for prices';

  @override
  String get checkIn => 'Check-in';

  @override
  String get checkOut => 'Checkout';

  @override
  String get guests => 'Guests';

  @override
  String get adults => 'Adults';

  @override
  String get children => 'Children';

  @override
  String get infants => 'Infants';

  @override
  String nights(int count) {
    return '$count nights';
  }

  @override
  String get cleaningFee => 'Cleaning fee';

  @override
  String get serviceFee => 'Service fee';

  @override
  String get total => 'Total';

  @override
  String get beforeTaxes => 'Before taxes';

  @override
  String get bookingConfirm => 'Confirm and pay';

  @override
  String get bookingSuccess => 'Booking confirmed!';

  @override
  String get bookingDetails => 'Booking details';

  @override
  String get myBookings => 'My bookings';

  @override
  String get bookingStatusPending => 'Pending';

  @override
  String get bookingStatusConfirmed => 'Confirmed';

  @override
  String get bookingStatusCancelled => 'Cancelled';

  @override
  String get bookingStatusCompleted => 'Completed';

  @override
  String get login => 'Log in';

  @override
  String get register => 'Sign up';

  @override
  String get logout => 'Log out';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get name => 'Name';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get hasAccount => 'Already have an account?';

  @override
  String get loginWithGoogle => 'Continue with Google';

  @override
  String get loginWithApple => 'Continue with Apple';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get settings => 'Settings';

  @override
  String get favorites => 'Favorites';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get chinese => '中文';

  @override
  String get homeTitle => 'Inspiration for your next trip';

  @override
  String get homeSubtitle => 'Discover amazing places to stay';

  @override
  String get searchResults => 'Search results';

  @override
  String get noResults => 'No results found';

  @override
  String get tryDifferentFilters => 'Try different filters';

  @override
  String get priceRange => 'Price range';

  @override
  String get sortBy => 'Sort by';

  @override
  String get sortPriceLow => 'Price: Low to High';

  @override
  String get sortPriceHigh => 'Price: High to Low';

  @override
  String get sortRating => 'Rating';

  @override
  String get sortNewest => 'Newest';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Something went wrong';

  @override
  String get retry => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get done => 'Done';

  @override
  String get seeAll => 'See all';

  @override
  String get night => 'night';

  @override
  String get perNightShort => '/night';

  @override
  String get showLess => 'Show less';

  @override
  String get noChargeYet => 'You won\'t be charged yet';

  @override
  String get listingNotFound => 'Listing not found';
}
