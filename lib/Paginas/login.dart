import 'package:flutter/material.dart';
import 'package:flutter_login/Componentes/text_field.dart';
import 'package:flutter_login/Componentes/my_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'conversion_divisa.dart';
class Login extends StatefulWidget {
  Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String userName = '';

  @override
  void initState() {
    super.initState();
    // Load the user's name when the widget initializes
    userName = getUserName();
  }

  // Function to sign the user in
  void signUserIn(BuildContext context) {
    String username = usernameController.text;
    String name = usernameController.text;

    saveUserData(username, name);

    // Update the state to display the user's name
    setState(() {
      userName = name;
    });
  }

  void saveUserData(String username, String name) {
    var box = Hive.box('userBox');
    box.put('username', username);
    box.put('name', name);
  }

  String getUserName() {
    var box = Hive.box('userBox');
    return box.get('name', defaultValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Logo
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.attach_money,
                  size: 80,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 50),

              // Bienvenido
              Text(
                'Bienvenido, $userName',
                style: TextStyle(
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              // User
              MyTextField(
                controller: usernameController,
                hintText: 'Nombre de Usuario',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // Password
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Not a member
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Olvidaste tu contrasena?'),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Boton de inicio de sesion
              // MyBoton(
              //   onTap: () => signUserIn(context),
              // ),

              CustomButton( onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConversionRatesPage()));
              } ,),

              const SizedBox(height: 200),

              

              // Registro
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No eres un miembro?'),
                  SizedBox(width: 4),
                  Text(
                    'Registrate',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
