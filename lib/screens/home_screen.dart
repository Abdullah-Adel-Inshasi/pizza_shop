import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pizza_shop/constants/colors.dart';
import 'package:pizza_shop/models/meal_model.dart';
import 'package:pizza_shop/screens/meal_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        BottomPersitantButton(),
      ],
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFA1BBC6).withOpacity(1),
                      offset: Offset(0, 3),
                      blurRadius: 6.0)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(),
                  SizedBox(height: 30),
                  SearchTextField(),
                  SizedBox(height: 20),
                  CategoriesText(),
                  SizedBox(height: 20),
                  CategoryBuilder(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25),
                MealsCarousel(
                  meals: pizzas,
                  title: 'Pizza',
                ),
                MealsCarousel(
                  meals: burgers,
                  title: 'Burger',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomPersitantButton extends StatelessWidget {
  const BottomPersitantButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              '${cart.length} Meals added',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 20),
      padding: EdgeInsets.only(right: 18),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: purple,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                color: green, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Text(
            'Cart',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            '|',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
          ),
          Text(
            '\$150',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class MealsCarousel extends StatelessWidget {
  final List<Meal> meals;
  final String title;

  MealsCarousel({this.meals, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF341557),
            ),
          ),
        ),
        ListView.builder(
          itemCount: meals.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            Meal meal = meals[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealScreen(
                      meal: meal,
                    ),
                  ),
                );
              },
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        Image.asset(
                          meal.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              meal.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0D1863)),
                            ),
                            SizedBox(height: 5),
                            Container(
                                width: 170,
                                child: Text(
                                  meal.description,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )),
                            // SizedBox(height: 5),
                            Text(
                              '\$${meal.price}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightGreen),
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        addToCart(meal);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: purple,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4A72A8).withOpacity(0.16),
                      blurRadius: 10,
                      offset: Offset(0, 15),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CategoriesText extends StatelessWidget {
  const CategoriesText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Text(
        'Categories',
        style:
            TextStyle(fontSize: 20, color: purple, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class CategoryBuilder extends StatefulWidget {
  @override
  _CategoryBuilderState createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  int selectedCategory = 0;

// TODO : fix the error where the number of items crops when user scrolls.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        itemCount: categories.length,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          Category category = categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInSine,
                    height: 80,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: selectedCategory == index
                          ? Colors.purple
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: selectedCategory == index
                                ? Color(0xFF647B9A).withOpacity(0.1)
                                : Colors.white,
                            offset: Offset(0, 0),
                            blurRadius: 10.0,
                            spreadRadius: 4),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                left: 16,
                                right: 18,
                                bottom: 28,
                                top: 23,
                                child: CustomPaint(
                                  foregroundPainter: CircleBlurPainter(
                                      circleWidth: 27, blurSigma: 30),
                                ),
                              ),
                              Image.asset(
                                category.imageUrl,
                                height: selectedCategory == index ? 33 : 23,
                                width: selectedCategory == index ? 33 : 23,
                              ),
                            ],
                          ),
                          Text(
                            category.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: selectedCategory == index
                                  ? Colors.white
                                  : Color(0xFF0D1863),
                              fontSize: selectedCategory == index ? 14 : 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration:
                          BoxDecoration(color: green, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'What do you want to eat today?',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomHeader extends StatefulWidget {
  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  String city = 'Gaza';
  List<String> cities = ['Gaza', 'Jbalia', 'Nusairat', 'Rafah', 'Khanyounis'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  return Scaffold.of(context).openDrawer();
                },
              ),
              SizedBox(width: 28),
              DropdownButton(
                value: city,
                iconEnabledColor: purple,
                iconDisabledColor: Colors.grey,
                items: cities
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            e,
                            style: TextStyle(
                              color: purple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String newValue) {
                  setState(() {
                    city = newValue;
                  });
                },
              ),
            ],
          ),
          CircleAvatar(
            child: Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 28,
            ),
            backgroundColor: purple,
            radius: 20,
          ),
        ],
      ),
    );
  }
}

class CircleBlurPainter extends CustomPainter {
  CircleBlurPainter({@required this.circleWidth, this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Color(0xFF627092)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void addToCart(Meal meal) {
  if (cart.contains(meal)) {
    print('${meal.name} already in cart');
  } else {
    cart.add(meal);
    print('${meal.name} added to cart');
  }
}
