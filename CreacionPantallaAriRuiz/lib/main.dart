import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivitatsProvider(),
      child: MaterialApp(
        title: 'Fitness Time',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fitness Time',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Handle menu button press
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Hero(
              tag: 'avatarTag',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/mujer44.jpg'),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Añade un relleno en todos los lados
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinea los widgets a la izquierda
            children: <Widget>[
              Text(
                'Hola Diana,', // Agrega la coma al final
                style: TextStyle(fontSize: 28), // Tamaño de fuente grande
              ),
              SizedBox(height: 20), // Espaciado entre los textos
              Text(
                'Come 5 veces al día y permanece hidratado durante el día', // Texto modificado
                style: TextStyle(fontSize: 14), // Tamaño de fuente del segundo texto
              ),
              SizedBox(height: 0), // Espaciado entre los textos y el enlace
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Manejar el tap en el enlace ("Mas detalles")
                      // Aquí puedes navegar a una nueva pantalla o realizar otra acción
                    },
                    child: Text(
                      'Mas detalles',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue, // Color del enlace
                        decoration: TextDecoration.underline, // Subrayar el enlace
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NovaActivitatScreen()),
                      );
                    },
                    child: Text('Nova activitat'),
                  ),
                ],
              ),

              SizedBox(height: 5), // Espaciado entre los textos
              Text(
                'Ultimas actividades', // Nuevo texto debajo del enlace
                style: TextStyle(fontSize: 14), // Tamaño de fuente del tercer texto
              ),
              Consumer<ActivitatsProvider>(
                builder: (context, activitatsProvider, _) {
                  final List<Activitat> activitats = activitatsProvider.activitats;
                  //final List<Activitat> activitats = [new Activitat(titulo: "Running", kms: 2, temps: 4),new Activitat(titulo: "Running", kms: 2, temps: 4), new Activitat(titulo: "Running", kms: 2, temps: 4),];

                  return Container(
                    height: 250,
                    child: ListView(
                      children: activitats.map((activitat) {

                        if (activitat != null && activitats.isNotEmpty) {
                          return Column(
                            children: [
                              ListTile(
                                title: CardItem(
                                  title: activitat.title ?? '', // Si el valor es nulo, se asigna una cadena vacía
                                  subtitle: '${activitat.subtitle} minutes' ?? '', // Si el valor es nulo, se asigna una cadena vacía
                                  distance: '${activitat.distance} Km' ?? '', // Si el valor es nulo, se asigna una cadena vacía
                                ),
                              ),
                              SizedBox(height: 10), // Espaciado entre las tarjetas
                            ],
                          );
                        } else {
                          return Text('Fallo');
                        }
                      }).toList(),

                    ),
                  );
                },
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 18.0,
                      percent: 0.70, // Porcentaje
                      center: Text("70.0%", style: TextStyle(fontSize: 18)),
                      progressColor: Colors.purple,
                    ),
                    SizedBox(height: 2), // Ajustado el espaciado entre el CircularPercentIndicator y el nuevo Text
                    Text(
                      'Objetivo mensual',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Indica el índice de la pestaña actual
        onTap: (index) {
          // Lógica para manejar la pulsación en las pestañas
          // Puedes utilizar un Navigator para navegar entre diferentes páginas
          // Ejemplo: Navigator.push(context, MaterialPageRoute(builder: (context) => NuevaPagina()));
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double height = 150;
  double weight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'MyProfile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Hero(
              tag: 'avatarTag',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/mujer44.jpg'),
                radius: 80,
              ),
            ),
            SizedBox(height: 10), // Espaciado entre la imagen y el texto

            // Nombre
            Text(
              'Carmen Martinez',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Texto "since 20 April 2022"
            Text(
              'since 20 April 2022',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 20), // Espaciado entre el texto y las tarjetas

            // Row con tres Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  color: Colors.purpleAccent,
                  child: SizedBox(
                    width: 120, // Ancho de la tarjeta
                    height: 140, // Altura reducida
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.access_time, size: 40, color: Colors.black),
                          SizedBox(height: 5),
                          Text('Time', style: TextStyle(fontSize: 14, color: Colors.black)),
                          SizedBox(height: 5),
                          Text(Provider.of<ActivitatsProvider>(context, listen: false)
                              .howManyTime().toString(), style: TextStyle(fontSize: 24, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.purpleAccent,
                  child: SizedBox(
                    width: 120, // Ancho de la tarjeta
                    height: 140, // Altura reducida
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.location_on, size: 40, color: Colors.black),
                          SizedBox(height: 5),
                          Text('Km', style: TextStyle(fontSize: 14, color: Colors.black)),
                          SizedBox(height: 5),
                          Text(Provider.of<ActivitatsProvider>(context, listen: false)
                              .howManyKm().toString(), style: TextStyle(fontSize: 24, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.purpleAccent,
                  child: SizedBox(
                    width: 120, // Ancho de la tarjeta
                    height: 140, // Altura reducida
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.directions_run, size: 40, color: Colors.black),
                          SizedBox(height: 5),
                          Text('Activities', style: TextStyle(fontSize: 14, color: Colors.black)),
                          SizedBox(height: 5),
                          Text(Provider.of<ActivitatsProvider>(context, listen: false)
                              .howManyActivities().toString(), style: TextStyle(fontSize: 24, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20), // Espaciado entre las tarjetas y los sliders

            // Slider para la altura con el texto "Height" a la izquierda
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: height,
                  max: 240,
                  min: 140,
                  divisions: 120,
                  label: height.round().toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      height = value;
                    });
                  },
                  activeColor: Colors.purple, // Color morado
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${height.round()} cm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

// Slider para el peso con el texto "Weight" a la izquierda
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: weight,
                  min: 30,
                  max: 180,
                  divisions: 150,
                  label: weight.round().toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      weight = value;
                    });
                  },
                  activeColor: Colors.purple, // Color morado
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weight.round()} kg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}

class NovaActivitatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController kmsController = TextEditingController();
    final TextEditingController tempsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Nova Activitat')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: kmsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Kms'),
          ),
          TextField(
            controller: tempsController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Temps (min)'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  final double kms = double.parse(kmsController.text);
                  final double temps = double.parse(tempsController.text);
                  final novaActivitat = Activitat(titulo: 'Running', kms: kms, temps: temps);

                  Provider.of<ActivitatsProvider>(context, listen: false)
                      .afegirActivitat(novaActivitat);

                  Navigator.pop(context); // Torna a la pantalla inicial
                },
                child: Text('Acceptar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Cancel·la l'acció
                },
                child: Text('Cancel·lar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String distance;

  CardItem({required this.title, required this.subtitle, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 30, // Ancho del contenedor
              height: 30, // Alto del contenedor
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Center(
                child: Icon(
                  Icons.directions_run, // Icono de la persona corriendo
                  size: 20, // Tamaño del icono
                ),
              ),
            ),
            SizedBox(width: 10), // Espacio entre el icono y el texto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, // Título de la actividad
                  style: TextStyle(fontSize: 24), // Tamaño de fuente del texto del Card
                ),
                SizedBox(height: 2), // Espaciado entre los textos
                Text(
                  subtitle, // Subtítulo de la actividad
                  style: TextStyle(fontSize: 16), // Tamaño de fuente del segundo texto del Card
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  distance, // Distancia de la actividad
                  style: TextStyle(fontSize: 24), // Tamaño de fuente del tercer texto del Card
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivitatsProvider extends ChangeNotifier {
  List<Activitat> _activitats = [];

  List<Activitat> get activitats => _activitats;

  void afegirActivitat(Activitat novaActivitat) {
    _activitats.add(novaActivitat);
    notifyListeners();
  }

  void borrarActivitats(){
    _activitats.clear();
    notifyListeners();
  }

  int howManyActivities(){
    return _activitats.length;
  }

  double howManyTime(){
    double hours = 0;
    _activitats.forEach((element) {
      hours += element.temps;
    });
    return hours;
  }

  double howManyKm(){
    double km = 0;
    _activitats.forEach((element) {
      km += element.distance;
    });
    return km;
  }
}

class Activitat {
  final String titulo;
  final double kms;
  final double temps; // Temps en minuts

  String get title => titulo;
  double get subtitle => temps;
  double get distance => kms;

  Activitat({required this.titulo, required this.kms, required this.temps});
}