import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../components/buttons/primary_button.dart';
import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/constants/app_enums.dart';
import '../screens_index.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  TextEditingController get nomeController => _nomeController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpController()),
      ],
      builder: (context, child) {
        return Consumer<SignUpController>(
          builder: (context, controller, child) => Scaffold(
            appBar: AppBar(backgroundColor: kPrimaryColor),
            backgroundColor: kPrimaryColor,
            //Padding = espaçamento
            body: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Text(
                      'Cadastro de Usuário',
                      style: TextStyle(
                          color: kBackgroundColor, fontSize: kLargeSize),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Nome de exibição',
                      style: TextStyle(color: kBackgroundColor),
                    ),
                    CustomTextFormField(
                      hintText: 'Ana Vieira',
                      controller: nomeController,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    const Text(
                      'E-mail',
                      style: TextStyle(color: kBackgroundColor),
                    ),
                    TextFormField(
                      //hintText: 'email@example.com',
                      controller: emailController,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    const Text('Senha',
                        style: TextStyle(color: kBackgroundColor)),
                    TextFormField(
                      //hintText: '********',
                      //isPassword: true,
                      controller: passwordController,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    const Text('Confirmar senha',
                        style: TextStyle(color: kBackgroundColor)),
                    const CustomTextFormField(
                      hintText: '********',
                      //isPassword: true,
                      // controller: controller.passwordController,
                    ),
                    const VerticalSpacerBox(size: SpacerSize.small),
                    const SizedBox(
                      height: kMediumSize,
                    ),
                    Center(
                      child: PrimaryButton(
                          text: const Text(
                            'Finalizar',
                            style: TextStyle(fontSize: kMediumLargeSize),
                          ),
                          //Criar rota
                          onPressed: () {
                            signUp(
                                nomeController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString());
                          }),
                    ),
                    const Spacer(),
                  ],
                )),
          ),
        );
      },
    );
  }

  void signUp(String nome, email, senha) async {
    print(nomeController.text);
    print(emailController.text);
    try {
      Response response =
          await post(Uri.parse('http://127.0.0.1:8000/api/user'), body: {
        'name': nomeController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });

      print(response.statusCode);

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print('Account Created!');
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
      print('Failed');
    }
  }
}
