import 'package:flutter/material.dart';

const String loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis eu enim efficitur orci porta varius. Vestibulum tincidunt sagittis velit. Nunc et diam massa. Cras ultrices lacinia scelerisque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam feugiat feugiat ligula sit amet feugiat. Maecenas sit amet accumsan enim. In maximus consectetur pharetra. Aliquam facilisis ac libero sit amet pharetra. Donec lorem elit, auctor non egestas laoreet, mollis at dui."
    "Proin condimentum tincidunt lectus, in vestibulum ligula sodales eu. Sed volutpat, dolor a viverra volutpat, dui justo faucibus elit, at dictum tortor lorem vitae arcu. Praesent id porta velit, sit amet volutpat mauris. Sed a sem nec nulla auctor sagittis. Phasellus non lacus eros. Maecenas congue, leo sed elementum vestibulum, enim lectus facilisis ante, sed molestie justo elit nec sem. Curabitur consequat lobortis neque vitae semper. Aenean ultrices cursus elit in tincidunt. Donec sagittis a justo vitae venenatis. Mauris blandit arcu nulla, egestas suscipit nibh lacinia lobortis. Integer nec sollicitudin risus. Curabitur in molestie urna. Ut a tempus nunc. Nam in massa tempus, mollis felis vel, dapibus tellus. Vestibulum congue orci non arcu bibendum, a tincidunt nibh maximus."
    "Vivamus odio ex, volutpat quis elementum ut, semper pulvinar libero. Nullam sed mauris nibh. Aenean lobortis quis nulla nec vestibulum. Vivamus tristique, dolor at varius pretium, velit felis dictum nunc, nec ullamcorper lectus justo eu nibh. Nullam diam dui, posuere eu dolor ut, elementum faucibus velit. Ut iaculis vitae ex id aliquet. Vestibulum luctus diam quam, id tristique est condimentum et. Curabitur vulputate orci nec rhoncus luctus. Ut consequat commodo congue. Cras fringilla eros non nunc dapibus, eu gravida eros vestibulum. Maecenas eu sapien at nisl cursus finibus sed et sem. Donec vel lacus ante. Donec tempor congue velit a convallis. Sed nisi leo, sodales vitae cursus ut, facilisis eget mauris."
    "Sed nisi ipsum, dapibus ac tortor nec, convallis laoreet odio. Etiam vel ante vel lectus aliquet vestibulum. Phasellus nulla velit, aliquam in hendrerit eu, accumsan at ex. Aenean faucibus suscipit mollis. Fusce eu urna tellus. Nam a velit libero. Mauris congue libero mi, non pharetra libero laoreet et. Ut feugiat arcu vel convallis tincidunt. Nunc posuere eros vitae tortor venenatis, sed mattis dui dictum. Maecenas volutpat nibh eu mauris blandit, ultrices vehicula magna rutrum. Maecenas porttitor nulla vitae eros ultrices, ut viverra nibh facilisis. Phasellus ut urna quam. Vestibulum vitae auctor arcu, vitae accumsan arcu. Nullam egestas eros id nunc sollicitudin congue. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    "Nam in tortor id nisi porttitor hendrerit ac ac metus. Suspendisse potenti. Phasellus sapien risus, porttitor quis eros a, ornare accumsan lacus. Aenean nibh nibh, efficitur vitae accumsan sed, commodo euismod leo. In id eleifend ipsum. Donec cursus dolor viverra tellus euismod fringilla et quis turpis. Ut consequat ultrices eros, at volutpat tortor blandit eget.";
final List<Widget> list = <Widget>[
  ListTile(
    title: Text('The Castro Theater',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('429 Castro St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Alamo Drafthouse Cinema',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('2550 Mission St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Roxie Theater',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('3117 16th St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('United Artists Stonestown Twin',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('501 Buckingham Way'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('AMC Metreon 16',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('135 4th St #3000'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  Divider(),
  ListTile(
    title: Text('K\'s Kitchen',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('757 Monterey Blvd'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Emmy\'s Restaurant',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('1923 Ocean Ave'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Chaiya Thai Restaurant',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('272 Claremont Blvd'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('La Ciccia',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('291 30th St'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
];
