import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/blocs/sign_in/sign_in_bloc.dart';
import 'package:spotify_clone/domain/cubits/obscure_text/obscure_text_cubit.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/presetation/screens/auth/sign_up_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/utils/validators.dart';
import 'package:spotify_clone/presetation/widgets/buttons/basic_button.dart';
import 'package:spotify_clone/presetation/widgets/buttons/social_buttons.dart';
import 'package:spotify_clone/presetation/widgets/fields/input_field.dart';

class SignInScreen extends StatefulWidget {
  static const String path = '/sign-in';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          final loading = state is LoadingSignInState;
          final errorText = state is ErrorSignInState ? state.error : null;
          final formError = state is ErrorFormSignInState || state is ErrorSignInState ? true : false;
          return Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(AppVectors.topPattern),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(AppVectors.bottomPattern),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppVectors.logo),
                      height_36,
                      Text(
                        'Accedi',
                        style: bold_24,
                      ),
                      height_24,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputField(
                              label: 'Email',
                              icon: Icons.email,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              autovalidateMode:
                                  formError ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                              enabled: !loading,
                            ),
                            height_24,
                            BlocBuilder<ObscureTextCubit, bool>(
                              builder: (context, state) {
                                return InputField(
                                  label: 'Password',
                                  icon: Icons.lock,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      context.read<ObscureTextCubit>().toggle();
                                    },
                                    icon: Icon(
                                      state == true ? Icons.visibility : Icons.visibility_off,
                                    ),
                                  ),
                                  controller: _passwordController,
                                  obscureText: state,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: requiredValidator,
                                  autovalidateMode: formError ? AutovalidateMode.onUserInteraction : null,
                                  enabled: !loading,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (errorText != null) ...[
                        height_8,
                        Text(
                          errorText,
                          style: regular_14.copyWith(color: red),
                        ),
                        height_8,
                      ] else ...[
                        height_24,
                      ],
                      BasicButton(
                        onPressed: () {
                          _signIn(context);
                        },
                        title: loading == true ? null : 'Accedi',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: SocialButtons(
                          onGoogleSignIn: () {
                            context.read<SignInBloc>().googleSignIn();
                          },
                          onAppleSignIn: () {
                            context.read<SignInBloc>().appleSignIn();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sei nuovo?',
                            style: semibold_16,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.only(left: 4),
                              ),
                            ),
                            onPressed: () {
                              context.go(SignUpScreen.path);
                            },
                            child: Text(
                              'Registrati ora!',
                              style: semibold_16.copyWith(color: green),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _signIn(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;
    final formState = _formKey.currentState?.validate() ?? false;
    context.read<SignInBloc>().signIn(email, password, formState);
  }
}
