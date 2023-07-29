import 'package:flutter/material.dart';
import 'package:water_buy/admi/home_adm.dart';
import 'package:water_buy/repartidor/notifit_repartidor.dart';
import 'perfil_repartidor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeRepartidor extends StatefulWidget {
  const HomeRepartidor({super.key});

  @override
  State<HomeRepartidor> createState() => _HomeRepartidorState();
}

class _HomeRepartidorState extends State<HomeRepartidor> {
  final _emailController = TextEditingController();
  final nombre = TextEditingController();
  final direccion = TextEditingController();
  final numeroTelefono = TextEditingController();

  int myIndex = 0;
  int counter = 0;

  Future<void> registrarRepartidor() async {
    final url = Uri.parse('http://localhost:3000/repartidores/registrarRepartidor');
    final cliente = {
      'nombre': nombre.text,
      'direccion': direccion.text,
      'telefono':  numeroTelefono.text,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(cliente),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200 && responseData['status'] == true) {
        // El cliente se registró exitosamente
        print('Repartidor creado exitosamente.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeAdm()),
        );
        // Aquí puedes agregar lógica para mostrar una confirmación al usuario o realizar otra acción.
      } else {
        // Hubo un error al registrar el cliente
        print('Error al registrar el cliente: ${responseData['message']}');
        // Aquí puedes agregar lógica para mostrar un mensaje de error al usuario.
      }
    } catch (e) {
      print('Error: $e');
      // Aquí puedes agregar lógica para mostrar un mensaje de error al usuario.
    }
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        backgroundColor: const Color.fromARGB(255, 29, 54, 112),
        title: const Text(
          'Home repartidor',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
        ),
        iconSize: 27,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
          _navigateToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 53, 102, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle_notifications,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Notificaciones',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 29, 54, 112),
              size: 30,
            ),
            label: 'Perfil',
            backgroundColor: Color.fromARGB(255, 0, 68, 123),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            children: [
              Center(
                child: Card(
                  color: const Color.fromARGB(255, 0, 68, 123),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 200,
                      height: 140,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/perfill.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Datos del repartidor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo';
                      } else if (!_isValidEmail(value)) {
                        return 'Ingresa un correo válido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'esau11@gmail.com',
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 1.0), // Ajusta el ancho del borde
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0), // Ajusta el padding
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  width: 300.0,
                  child: TextFormField(
                    controller: nombre,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Ingresa tu nombre',
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 1.0), // Ajusta el ancho del borde
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0), // Ajusta el padding
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Center(
                  child: SizedBox(
                    width: 300.0,
                    child: TextFormField(
                      controller: direccion,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nombre';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Ingresa tu direccion',
                        labelText: 'Direccion',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 1.0), // Ajusta el ancho del borde
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0), // Ajusta el padding
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Center(
                  child: SizedBox(
                    width: 300.0,
                    child: TextFormField(
                      controller: numeroTelefono,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nombre';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Ingresa tu direccion',
                        labelText: 'Numero de telefono',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                              width: 1.0), // Ajusta el ancho del borde
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 5.0), // Ajusta el padding
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                elevation: 20,
                minWidth: 200.0,
                height: 40.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  registrarRepartidor();
                },
                color: Color.fromARGB(255, 25, 70, 159),
                child: Column(
                  children: [
                    const Text(
                      'Agregar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // ... Aquí puedes agregar cualquier otro widget que desees mostrar en el botón ...
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeRepartidor()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotifiRepartidor()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PerfilRepartidor()),
        );

        break;
      default:
        break;
    }
  }

  bool _isValidEmail(String email) {
    // Utiliza una expresión regular para validar el formato del correo electrónico
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
