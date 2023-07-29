import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'inicio_sesion.dart';

class RegisterWater extends StatefulWidget {
  const RegisterWater({Key? key}) : super(key: key);

  @override
  State<RegisterWater> createState() => _RegisterWaterState();
}

class _RegisterWaterState extends State<RegisterWater> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  List<dynamic>? responseData;

  Future<void> _registrarCliente() async {
    final url = Uri.parse('http://localhost:3000/clientes/registrarCliente');
    final cliente = {
      'nombre': _nameController.text,
      'correoElectronico': _emailController.text,
      'contrasenia': _passwordController.text,
      'direccion': 'st. weast',
      'telefono': '9991234567',
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
        print('Cliente creado exitosamente.');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InicioWater()),
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

  Future<void> fetchData() async {
    try {
      var response = await http.get(
          Uri.parse('http://localhost:3000/repartidores/obtenerRepartidores'));
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          responseData = jsonResponse[
              'data']; // Actualiza la variable de estado con la información de response
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
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
                    'Únete',
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
                            controller: _nameController,
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
                              hintText: 'Ingrese su contraseña',
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
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300.0,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor confirma tu contraseña';
                              } else if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirmar contraseña',
                              labelText: 'Confirmar contraseña',
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
                              // La validación ha sido exitosa, puedes continuar con el registro
                              _registrarCliente(); // Llama a la función para hacer la solicitud POST
                              // Aquí puedes agregar lógica para mostrar un indicador de carga mientras se procesa la solicitud.
                            }
                          },
                          color: const Color.fromARGB(255, 47, 105, 168),
                          child: const Text(
                            'Registrarse',
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
