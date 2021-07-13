import 'app_setting.dart';
import 'background_config.dart';

/// HorizonLayout : [{'layout':'logo','showMenu':true,'showLogo':true,'showSearch':true,'name':'','color':'','menuIcon':{'name':'','fontFamily':''}},{'layout':'header_text','fontSize':25.0,'title':'Most popular, \ntrending fashion ','padding':30.0,'height':0.2,'showSearch':true,'isSafeArea':true},{'backgroundInput':false,'fontSize':13,'padding':19,'text':'Header','radius':30,'textOpacity':1,'marginRight':9,'marginBottom':0,'boxShadow':{'blurRadius':10.0,'colorOpacity':0.1,'spreadRadius':10.0,'x':0,'y':0},'layout':'header_search','marginLeft':5,'showShadow':true,'borderInput':false,'marginTop':6,'shadow':10,'height':85},{'type':'icon','hideTitle':false,'originalColor':false,'noBackground':false,'wrap':false,'size':1.0,'columns':3,'radius':50.0,'border':1.0,'shadow':15.0,'boxShadow':{'blurRadius':10.0,'colorOpacity':0.1,'spreadRadius':10.0,'x':0,'y':0},'layout':'category','marginLeft':10.0,'marginRight':10.0,'marginTop':10.0,'marginBottom':10.0,'data':[],'items':[{'originalColor':false,'title':false,'keepDefaultTitle':false,'colors':['#3CC2BF','#3CC2BF'],'`image`':'https://user-images.githubusercontent.com/1459805/62820029-2e679f00-bb88-11e9-80de-fdf115cfd942.png','tag':'58','category':'58'}]},{'layout':'bannerImage','design':'default','fit':'cover','marginLeft':5,'intervalTime':3,'items':[{'category':28,'image':'https://user-images.githubusercontent.com/1459805/59846818-12672e80-938b-11e9-8184-5f7bfe66f1a2.png','padding':15},{'padding':15,'image':'https://user-images.githubusercontent.com/1459805/60091575-1f12ca80-976f-11e9-962c-bdccff60d143.png','category':29},{'image':'https://user-images.githubusercontent.com/1459805/60091808-a19b8a00-976f-11e9-9cc7-576ca05c2442.png','padding':15,'product':30}],'marginBottom':5,'autoPlay':false,'isSlider':true,'height':0.2,'marginRight':5,'marginTop':5,'radius':2},{'isSlider':false,'marginBottom':0,'marginLeft':10,'height':0.22,'layout':'bannerImage','marginTop':0,'items':[{'image':'https://user-images.githubusercontent.com/1459805/59846820-12672e80-938b-11e9-8fa6-b331b7db331d.png','padding':5,'url':'https://inspireui.com'}],'marginRight':10,'fit':'cover'},{'isSlider':false,'items':[{'category':29,'padding':5,'image':'https://user-images.githubusercontent.com/1459805/59846823-12ffc500-938b-11e9-8d93-65ead3d6b1dd.png'},{'padding':5,'category':26,'image':'https://user-images.githubusercontent.com/1459805/59846824-12ffc500-938b-11e9-8d5a-fc42cb1b7658.png'}],'fit':'cover','marginRight':10,'height':0.35,'marginLeft':10,'marginTop':10,'marginBottom':0,'layout':'bannerImage'},{'category':'57','name':'Woman Collections','layout':'threeColumn','isSnapping':true},{'category':'58','layout':'listTile','name':'Title'},{'layout':'blog','name':'Blog'}]
/// Setting : {'MainColor':'#3FC1BE','ProductListLayout':'list','StickyHeader':true,'ProductDetail':'simpleType','FontFamily':'Raleway','TabBarConfig':{'isSafeArea':true,'color':'','radiusTopLeft':0.0,'radiusTopRight':0.0,'radiusBottomLeft':0.0,'radiusBottomRight':0.0,'paddingLeft':0.0,'paddingRight':0.0,'paddingBottom':0.0,'paddingTop':0.0,'marginTop':0.0,'marginBottom':0.0,'marginLeft':0.0,'marginRight':0.0,'boxShadow':{'blurRadius':10.0,'colorOpacity':0.1,'spreadRadius':10.0,'x':0,'y':0},'TabBarIndicator':{'indicatorSize':'label','indicatorColor':'','unselectedLabelColor':'','height':0.0,'tabPosition':0.0,'topRightRadius':0.0,'topLeftRadius':0.0,'bottomRightRadius':0.0,'bottomLeftRadius':0.0,'color':0.0,'horizontalPadding':0.0,'verticalPadding':0.0,'strokeWidth':0.0,'radius':0.0,'distanceFromCenter':0.0},'TabBarCenter':{'position':0,'radius':0.0,'color':'','marginTop':0.0,'marginBottom':0.0,'marginLeft':0.0,'marginRight':0.0,'boxShadow':{'blurRadius':10.0,'colorOpacity':0.1,'spreadRadius':10.0,'x':0,'y':0}}}}
/// TabBar : [{'layout':'home','icon':'home','pos':100,'fontFamily':'CupertinoIcons','key':'p1q235ba14'},{'pos':200,'layout':'category','icon':'rectangle_grid_1x2','fontFamily':'CupertinoIcons','categoryLayout':'card','key':'hwu0rkrizt'},{'key':'2reihs4qzc','icon':'search','layout':'search','fontFamily':'CupertinoIcons','pos':300,'size':24},{'pos':400,'icon':'bag','layout':'cart','categoryLayout':'cart','key':'a2xts0oou6','fontFamily':'CupertinoIcons'},{'layout':'profile','fontFamily':'CupertinoIcons','pos':500,'key':'69jw5yx12d','icon':'person'}]
/// Drawer : {'logo':'assets/images/logo.png','items':[{'type':'home','show':true},{'type':'blog','show':true},{'type':'login','show':true},{'show':true,'type':'category'}]}
/// Background : {'color':'#eee','image':'https://google.com','height':0.18,'layout':'background'}

class AppConfig {
  late AppSetting settings;
  BackgroundConfig? background;
  List<TabBarMenuConfig> tabBar = [];
  DrawerMenuConfig? drawer;
  dynamic jsonData;
  List<String>? searchSuggestion = [];

  AppConfig({
    required this.settings,
    required this.tabBar,
    this.drawer,
    this.background,
    this.searchSuggestion,
  });

  AppConfig.fromJson(dynamic json) {
    if (json['Setting'] != null) {
      settings = AppSetting.fromJson(json['Setting']);
    }

    tabBar = [];
    json['TabBar'].forEach((v) {
      tabBar.add(TabBarMenuConfig.fromJson(v));
    });

    drawer = json['Drawer'] != null
        ? DrawerMenuConfig.fromJson(json['Drawer'])
        : null;

    background = json['Background'] != null
        ? BackgroundConfig.fromJson(json['Background'])
        : null;

    if (json['searchSuggestion'] != null) {
      searchSuggestion = [];
      json['searchSuggestion'].forEach((v) {
        searchSuggestion!.add(v);
      });
    }
    // ignore: prefer_initializing_formals
    jsonData = json;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['TabBar'] = tabBar.map((v) => v.toJson()).toList();
    if (drawer != null) {
      map['Drawer'] = drawer?.toJson();
    }
    if (background != null) {
      map['Background'] = background?.toJson();
    }
    return map;
  }
}

/// logo : 'assets/images/logo.png'
/// items : [{'type':'home','show':true},{'type':'blog','show':true},{'type':'login','show':true},{'show':true,'type':'category'}]

class DrawerMenuConfig {
  String? key;
  String? logo;
  List<DrawerItemsConfig>? items;

  DrawerMenuConfig({this.logo, this.key, this.items});

  DrawerMenuConfig.fromJson(dynamic json) {
    key = json['key'];
    logo = json['logo'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(DrawerItemsConfig.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['logo'] = logo;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : 'home'
/// show : true

class DrawerItemsConfig {
  String? type;
  bool? show;

  DrawerItemsConfig({this.type, this.show});

  DrawerItemsConfig.fromJson(dynamic json) {
    type = json['type'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['type'] = type;
    map['show'] = show;
    return map;
  }
}

/// layout : 'home'
/// icon : 'home'
/// pos : 100
/// fontFamily : 'CupertinoIcons'
/// key : 'p1q235ba14'

class TabBarMenuConfig {
  String? layout;
  String? label;
  int? pos;
  String? key;
  String icon = 'home';
  String fontFamily = 'Tahoma';
  String categoryLayout = 'card';

  dynamic jsonData;
  dynamic categories;
  dynamic images;

  TabBarMenuConfig(
      {this.layout,
      this.icon = 'home',
      this.label,
      this.pos,
      this.fontFamily = 'Tahoma',
      this.jsonData,
      this.categories,
      this.images,
      this.categoryLayout = 'card',
      this.key});

  TabBarMenuConfig.fromJson(dynamic json) {
    layout = json['layout'];
    icon = json['icon'];
    label = json['label'];
    pos = json['pos'];
    fontFamily = json['fontFamily'] ?? 'Tahoma';
    key = json['key'];
    categories = json['categories'];
    images = json['images'];
    categoryLayout = json['categoryLayout'] ?? 'card';
    // ignore: prefer_initializing_formals
    jsonData = json;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['layout'] = layout;
    map['icon'] = icon;
    map['pos'] = pos;
    map['fontFamily'] = fontFamily;
    map['key'] = key;
    return map;
  }
}
