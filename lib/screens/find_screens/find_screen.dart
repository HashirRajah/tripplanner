import 'package:flutter/material.dart';
import 'package:tripplanner/models/useful_link_model.dart';
import 'package:tripplanner/screens/find_screens/find_screen_app_bar.dart';
import 'package:tripplanner/screens/find_screens/useful_links.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});
  //
  List<Widget> buildBody() {
    List<Widget> bodyWidgets = [];
    //
    bodyWidgets.add(
      UsefulLinksCard(
        title: 'Flights',
        links: [
          UsefulLinkModel(
            name: 'Skyscanner',
            link: 'https://www.skyscanner.net/',
          ),
          UsefulLinkModel(
            name: 'Agoda',
            link: 'https://flights.agoda.com/',
          ),
          UsefulLinkModel(
            name: 'Booking.com',
            link: 'https://booking.kayak.com/',
          ),
          UsefulLinkModel(
            name: 'Trip.com',
            link:
                'https://us.trip.com/?allianceid=742331&sid=1621928&ppcid=ckid-5658712367_adid-660427218467_akid-kwd-11635721_adgid-144762786930&utm_source=google&utm_medium=cpc&utm_campaign=12578580660&gad=1&gclid=Cj0KCQjwoeemBhCfARIsADR2QCv6fpWI7JUkZxb6czV5i8DxDCS6ztyAMi2avFl4SQoZrCdUey3Ox6QaAuP8EALw_wcB&locale=en-us',
          ),
        ],
        svgFilePath: 'assets/svgs/flights.svg',
      ),
    );
    //
    bodyWidgets.add(
      UsefulLinksCard(
        title: 'Hotels',
        links: [
          UsefulLinkModel(
            name: 'Skyscanner',
            link: 'https://www.skyscanner.net/hotels',
          ),
          UsefulLinkModel(
            name: 'Agoda',
            link: 'https://www.agoda.com/',
          ),
          UsefulLinkModel(
            name: 'Booking.com',
            link: 'https://www.booking.com/',
          ),
          UsefulLinkModel(
            name: 'Tripadvisor',
            link: 'https://www.tripadvisor.com/',
          ),
          UsefulLinkModel(
            name: 'Trip.com',
            link:
                'https://us.trip.com/?allianceid=742331&sid=1621928&ppcid=ckid-5658712367_adid-660427218467_akid-kwd-11635721_adgid-144762786930&utm_source=google&utm_medium=cpc&utm_campaign=12578580660&gad=1&gclid=Cj0KCQjwoeemBhCfARIsADR2QCv6fpWI7JUkZxb6czV5i8DxDCS6ztyAMi2avFl4SQoZrCdUey3Ox6QaAuP8EALw_wcB&locale=en-us',
          ),
        ],
        svgFilePath: 'assets/svgs/hotels.svg',
      ),
    );
    //
    bodyWidgets.add(
      UsefulLinksCard(
        title: 'Car Rentals',
        links: [
          UsefulLinkModel(
            name: 'Skyscanner',
            link: 'https://www.skyscanner.net/carhire',
          ),
          UsefulLinkModel(
            name: 'Agoda',
            link: 'https://www.rentalcars.com/',
          ),
          UsefulLinkModel(
            name: 'Booking.com',
            link: 'https://www.booking.com/cars/',
          ),
          UsefulLinkModel(
            name: 'Tripadvisor',
            link: 'https://www.tripadvisor.com/RentalCars',
          ),
          UsefulLinkModel(
            name: 'Trip.com',
            link: 'https://us.trip.com/carhire/',
          ),
        ],
        svgFilePath: 'assets/svgs/car_rental.svg',
      ),
    );
    //
    bodyWidgets.add(
      UsefulLinksCard(
        title: 'Airport Transfers',
        links: [
          UsefulLinkModel(
            name: 'Agoda',
            link: 'https://agoda.mozio.com/',
          ),
          UsefulLinkModel(
            name: 'Booking.com',
            link: 'https://www.booking.com/taxi/',
          ),
        ],
        svgFilePath: 'assets/svgs/airport_transfers.svg',
      ),
    );
    //
    return bodyWidgets;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const FindSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: spacing_16,
              vertical: spacing_8,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: buildBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
