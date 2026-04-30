// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '商城 Demo';

  @override
  String get appName => '商城 Demo';

  @override
  String get navHome => '首页';

  @override
  String get navSearch => '搜索';

  @override
  String get navFavorites => '收藏';

  @override
  String get navProfile => '我的';

  @override
  String get searchWhere => '地点';

  @override
  String get searchWhen => '时间';

  @override
  String get searchWho => '人数';

  @override
  String get searchAnywhere => '任何地点';

  @override
  String get searchAnyWeek => '任何时间';

  @override
  String get searchAddGuests => '添加人数';

  @override
  String get searchButton => '搜索';

  @override
  String get categoryNew => '新';

  @override
  String get guestFavorite => '房客最爱';

  @override
  String perNight(String price) {
    return '$price/晚';
  }

  @override
  String reviewCount(int count) {
    return '$count条评价';
  }

  @override
  String listingHosted(String hostName) {
    return '房东：$hostName';
  }

  @override
  String get superhost => '超赞房东';

  @override
  String hostingYears(int count) {
    return ' hosting $count年';
  }

  @override
  String responseRate(int rate) {
    return '$rate%回复率';
  }

  @override
  String get contactHost => '联系房东';

  @override
  String showAllAmenities(int count) {
    return '查看全部$count项设施';
  }

  @override
  String get whatThisPlaceOffers => '房源详情';

  @override
  String get guestFavoriteTitle => '房客最爱';

  @override
  String get guestFavoriteSubtitle => '最受欢迎的房源之一';

  @override
  String get showMore => '查看更多';

  @override
  String reviewsTitle(int count) {
    return '$count条评价';
  }

  @override
  String get reserve => '预订';

  @override
  String get addDates => '选择日期查看价格';

  @override
  String get checkIn => '入住';

  @override
  String get checkOut => '退房';

  @override
  String get guests => '人数';

  @override
  String get adults => '成人';

  @override
  String get children => '儿童';

  @override
  String get infants => '婴幼儿';

  @override
  String nights(int count) {
    return '$count晚';
  }

  @override
  String get cleaningFee => '清洁费';

  @override
  String get serviceFee => '服务费';

  @override
  String get total => '合计';

  @override
  String get beforeTaxes => '不含税费';

  @override
  String get bookingConfirm => '确认并支付';

  @override
  String get bookingSuccess => '预订成功！';

  @override
  String get bookingDetails => '预订详情';

  @override
  String get myBookings => '我的预订';

  @override
  String get bookingStatusPending => '待确认';

  @override
  String get bookingStatusConfirmed => '已确认';

  @override
  String get bookingStatusCancelled => '已取消';

  @override
  String get bookingStatusCompleted => '已完成';

  @override
  String get login => '登录';

  @override
  String get register => '注册';

  @override
  String get logout => '退出登录';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get name => '姓名';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get noAccount => '没有账号？';

  @override
  String get hasAccount => '已有账号？';

  @override
  String get loginWithGoogle => '使用 Google 登录';

  @override
  String get loginWithApple => '使用 Apple 登录';

  @override
  String get profileTitle => '个人中心';

  @override
  String get editProfile => '编辑资料';

  @override
  String get settings => '设置';

  @override
  String get favorites => '收藏夹';

  @override
  String get language => '语言';

  @override
  String get english => 'English';

  @override
  String get chinese => '中文';

  @override
  String get homeTitle => '下一个旅行灵感';

  @override
  String get homeSubtitle => '发现更多精彩的住宿';

  @override
  String get searchResults => '搜索结果';

  @override
  String get noResults => '未找到结果';

  @override
  String get tryDifferentFilters => '试试其他筛选条件';

  @override
  String get priceRange => '价格区间';

  @override
  String get sortBy => '排序';

  @override
  String get sortPriceLow => '价格从低到高';

  @override
  String get sortPriceHigh => '价格从高到低';

  @override
  String get sortRating => '评分最高';

  @override
  String get sortNewest => '最新上架';

  @override
  String get loading => '加载中...';

  @override
  String get error => '出了点问题';

  @override
  String get retry => '重试';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get back => '返回';

  @override
  String get close => '关闭';

  @override
  String get done => '完成';

  @override
  String get seeAll => '查看全部';

  @override
  String get night => '晚';

  @override
  String get perNightShort => '/晚';

  @override
  String get showLess => '收起';

  @override
  String get noChargeYet => '暂时不会扣费';

  @override
  String get listingNotFound => '未找到房源';
}
