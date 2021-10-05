part of 'user_homepage.dart';

class _GreetingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocSelector<AppBloc, AppState, User>(
          selector: (s) => s.user,
          builder: (context, user) {
            if (user.isNotEmpty) {
              return Text(
                _generateGreeting() + ', ${user.firstName} ${user.lastName}!',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.w700
                ),
              );
            }
            return Text(
              _generateGreeting() + ', John Doe!',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700
              ),
            );
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          'How can I help you today?',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  String _generateGreeting() {
    final now = DateTime.now();
    if (now.isAfter(DateTime(now.year, now.month, now.day, 11, 59)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 18))) {
      return 'Good afternoon';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 15, 59)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 21))) {
      return 'Good evening';
    }
    if (now.isAfter(DateTime(now.year, now.month, now.day, 20, 59)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 23, 59))) {
      return 'Good night';
    }
    return 'Good morning';
  }
}

class _ErrandCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 36.0),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset(
                'assets/shopping_cart.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Theme.of(context).primaryColorDark,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send on errand',
                      textWidthBasis: TextWidthBasis.parent,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Place an order at your favorite stores through us, "
                          "and we'll deliver it to your doorstep.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(OptionsPage.route(OrderType.errand));
        },
      ),
    );
  }
}

class _DeliveryCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 48),
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset(
                'assets/dispatch_rider.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Theme.of(context).primaryColorDark,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make a delivery',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Place a request to get your item(s) delivered to its safe destination.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(OptionsPage.route(OrderType.delivery));
        },
      ),
    );
  }
}