import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/blocs/sign_up/sign_up_bloc.dart';
import 'package:spotify_clone/domain/cubits/confirm_password/confirm_password_cubit.dart';
import 'package:spotify_clone/domain/cubits/obscure_text/obscure_text_cubit.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/presetation/screens/auth/sign_in_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/utils/validators.dart';
import 'package:spotify_clone/presetation/widgets/buttons/basic_button.dart';
import 'package:spotify_clone/presetation/widgets/buttons/social_buttons.dart';
import 'package:spotify_clone/presetation/widgets/fields/input_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String path = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          final loading = state is LoadingSignUpState;
          final errorText = state is ErrorSignUpState ? state.error : null;
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
                        'Registrati',
                        style: bold_24,
                      ),
                      height_24,
                      BlocProvider(
                        create: (context) => ConfirmPasswordCubit(),
                        child: BlocBuilder<ConfirmPasswordCubit, String>(
                          builder: (context, state) {
                            return Form(
                              key: _formKey,
                              child: Column(
                                spacing: 24,
                                children: [
                                  InputField(
                                    label: 'Email',
                                    icon: Icons.email,
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: emailValidator,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    enabled: !loading,
                                  ),
                                  BlocProvider(
                                    create: (context) => ObscureTextCubit(),
                                    child: BlocBuilder<ObscureTextCubit, bool>(
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
                                          validator: passwordValidator,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          onChanged: (value) {
                                            context.read<ConfirmPasswordCubit>().passwordChange(value);
                                          },
                                          enabled: !loading,
                                        );
                                      },
                                    ),
                                  ),
                                  BlocProvider(
                                    create: (context) => ObscureTextCubit(),
                                    child: BlocBuilder<ObscureTextCubit, bool>(
                                      builder: (context, state) {
                                        return InputField(
                                          label: 'Conferma password',
                                          icon: Icons.lock,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context.read<ObscureTextCubit>().toggle();
                                            },
                                            icon: Icon(
                                              state == true ? Icons.visibility : Icons.visibility_off,
                                            ),
                                          ),
                                          controller: _confirmPasswordController,
                                          obscureText: state,
                                          keyboardType: TextInputType.visiblePassword,
                                          validator: confirmPasswordValidator(_passwordController.text).build(),
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          enabled: !loading,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
                        title: loading == true ? null : 'Registrati',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: SocialButtons(
                          onGoogleSignIn: () {
                            context.read<SignUpBloc>().googleSignIn();
                          },
                          onAppleSignIn: () {
                            context.read<SignUpBloc>().appleSignIn();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hai già un account?',
                            style: semibold_16,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.only(left: 4),
                              ),
                            ),
                            onPressed: () {
                              context.go(SignInScreen.path);
                            },
                            child: Text(
                              'Accedi ora!',
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
    _confirmPasswordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  void _signIn(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final formState = _formKey.currentState?.validate() ?? false;
    context.read<SignUpBloc>().signIn(email, password, confirmPassword, formState);
  }
}
