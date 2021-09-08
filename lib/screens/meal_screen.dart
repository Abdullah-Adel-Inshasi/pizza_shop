import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pizza_shop/constants/colors.dart';
import 'package:pizza_shop/models/meal_model.dart';

// import 'order_screen.dart';

class MealScreen extends StatefulWidget {
  final Meal meal;

  MealScreen({this.meal});

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  int _numPages;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int amountOfMeals = 1.clamp(0, 5);

  int selectedSize = 0;

  List<String> toppings = ['Pepperoni', 'Extra Cheese', 'Garlic Bread'];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFFC3D61B),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _numPages = widget.meal.images.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            itemCount: widget.meal.images.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              String image = widget.meal.images[index];
                              return Image.asset(
                                image,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 60,
                            right: 19,
                            left: 19,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    ArrowButton(
                                        icon:
                                            Icons.keyboard_arrow_left_rounded),
                                    SizedBox(width: 15),
                                    Row(
                                      children: _buildPageIndicator(),
                                    ),
                                  ],
                                ),
                                ArrowButton(
                                    icon: Icons.keyboard_arrow_right_rounded),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 60,
                            left: 30,
                            right: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF341557).withOpacity(0.8),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.close_sharp,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                  ),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF341557).withOpacity(0.8),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.shopping_basket_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      transform: Matrix4.translationValues(0, -45, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6F8FAE).withOpacity(0.4),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 65,
                            child: Container(
                              transform: Matrix4.translationValues(0, -25, 0),
                              height: 50,
                              width: 50,
                              child: Center(
                                  child: Icon(
                                Icons.favorite_outline_rounded,
                                color: Colors.white,
                                size: 35,
                              )),
                              decoration: BoxDecoration(
                                color: Color(0xFFEE3169),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.meal.name,
                                  style: TextStyle(
                                      color: purple,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '\$${widget.meal.price.toInt()}',
                                        style: TextStyle(
                                            color: green, fontSize: 22),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  amountOfMeals--;
                                                });
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF341557)
                                                      .withOpacity(0.8),
                                                ),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 20,
                                                )),
                                              ),
                                            ),
                                            Text(
                                              amountOfMeals.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: purple),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  amountOfMeals++;
                                                });
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF341557)
                                                      .withOpacity(0.8),
                                                ),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  widget.meal.description,
                                  style: TextStyle(color: Color(0xFF0D1863)),
                                ),
                                SizedBox(height: 40),
                                Text('Choose size:'),
                                SizedBox(height: 20),
                                Container(
                                  height: 30,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: sizes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String size = sizes[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedSize = index;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 150),
                                            height: 30,
                                            width: 56,
                                            decoration: BoxDecoration(
                                                color: index == selectedSize
                                                    ? Color(0xFF572D86)
                                                    : Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: index == selectedSize
                                                        ? Colors.transparent
                                                        : Color(0xFFE7E7EF)),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                size,
                                                style: TextStyle(
                                                    color: index == selectedSize
                                                        ? Colors.white
                                                        : Color(0xFF572D86),
                                                    fontSize:
                                                        index == selectedSize
                                                            ? 18
                                                            : 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      // BoxShadow(
                      //     color: Color(0xFF6F8FAE).withOpacity(1),
                      //     blurRadius: 10,
                      //     offset: Offset(0, 3))
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Toppings',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF341557)),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Select up to two toppings',
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xFF341557)),
                                )
                              ],
                            ),
                            Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(color: green),
                              child: Center(
                                child: Text(
                                  'Obligatory',
                                  style: TextStyle(
                                      color: Color(0xFF758017), fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 20, bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    String topping = toppings[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F9FC),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6F8FAE).withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 3))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              topping,
                              style: TextStyle(
                                color: Color(0xFF354C7B),
                              ),
                            ),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF92A3C5), width: 1),
                                  shape: BoxShape.circle),
                            )
                          ],
                        ),
                      ),
                    );
                  }, childCount: toppings.length),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25,
            left: 26,
            right: 26,
            child: GestureDetector(
              onTap: () {
                onOrdersBoxPressed(context);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF572D86),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 33,
                      width: 33,
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        '2',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                    ),
                    Text(
                      'My Cart',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${widget.meal.price}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onOrdersBoxPressed(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 40, left: 32, right: 40),
              sliver: SliverToBoxAdapter(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF341557),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.shopping_basket_outlined,
                              color: green, size: 40),
                          SizedBox(width: 10),
                          Text(
                            'My Order',
                            style: TextStyle(
                                color: Color(0xFF572D86), fontSize: 25),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          cart.clear();
                        },
                        child: Text('Clear Cart',
                            style: TextStyle(
                                color: Color(0xFF572D86), fontSize: 18)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 60, bottom: 0, left: 12, right: 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    Meal meal = cart[index];
                    int mealNumber = 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    meal.imageUrl,
                                    fit: BoxFit.cover,
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    meal.name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF341557),
                                    ),
                                  ),
                                  Text(
                                    '\$${meal.price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 100,
                            width: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Color(0xFFE2EDF2),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      mealNumber++;
                                    },
                                    child: Icon(Icons.add)),
                                Text(mealNumber.toString()),
                                GestureDetector(
                                    onTap: () {
                                      mealNumber--;
                                    },
                                    child: Icon(Icons.remove))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: cart.length,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class ArrowButton extends StatelessWidget {
  final IconData icon;

  ArrowButton({this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO : make the buttons change the selected image
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: Color(0xFFD1CAC4).withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: Color(0xFF341557),
          size: 25,
        ),
      ),
    );
  }
}
//
