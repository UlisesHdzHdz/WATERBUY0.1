import 'package:flutter/material.dart';
import '../menu_producto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InicioWater extends StatefulWidget {
  const InicioWater({Key? key}) : super(key: key);

  @override
  State<InicioWater> createState() => _InicioWaterState();
}

class _InicioWaterState extends State<InicioWater> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Map<String, dynamic>? responseData;

  Future<void> iniciarSesion() async {
    try {
      var url = Uri.parse(
          'http://localhost:3000/clientes/iniciarSesion/${_emailController.text}/${_passwordController.text}');
      var response = await http.get(url);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          // Save data in storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userData', jsonEncode(jsonResponse['data']));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuProducto()),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 47, 105, 168),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 80.0,
              ),
              children: [
                Container(
                    decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 300.0,
                          child: TextFormField(
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
                                  horizontal: 10.0,
                                  vertical: 5.0), // Ajusta el padding
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                  horizontal: 10.0,
                                  vertical: 5.0), // Ajusta el padding
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            controller: _passwordController,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña';
                              } else if (value.length < 8) {
                                return 'La contraseña debe tener al menos 8 caracteres';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '*********',
                              labelText: 'Contraseña',
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
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: MaterialButton(
                          elevation: 15,
                          height: 45,
                          minWidth: 300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // La validación ha sido exitosa, puedes continuar con el inicio de sesión
                              // Aquí puedes agregar tu lógica de autenticación
                              iniciarSesion();
                            }
                          },
                          color: const Color.fromARGB(255, 47, 105, 168),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    // Utiliza una expresión regular para validar el formato del correo electrónico
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
