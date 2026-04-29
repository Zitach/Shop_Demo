import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/auth/presentation/providers/auth_provider.dart';
import 'package:shop_demo/features/auth/presentation/widgets/social_login_button.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    final authState = ref.read(authProvider);
    if (authState.hasValue && authState.value != null && mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),

                // Title
                Text(
                  'Welcome back',
                  style:
                      AppTypography.displayXl.copyWith(color: AppColors.ink),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppTypography.bodyMd.copyWith(
                      color: AppColors.muted,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide: const BorderSide(color: AppColors.hairline),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide:
                          const BorderSide(color: AppColors.ink, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.md,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.base),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: AppTypography.bodyMd.copyWith(
                      color: AppColors.muted,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide: const BorderSide(color: AppColors.hairline),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      borderSide:
                          const BorderSide(color: AppColors.ink, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base,
                      vertical: AppSpacing.md,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.muted,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // Login button
                AppButton.primary(
                  label: 'Log in',
                  onTap: authState.isLoading ? null : _handleLogin,
                  enabled: !authState.isLoading,
                ),

                // Error message
                if (authState.hasError) ...[
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    _extractErrorMessage(authState.error),
                    style:
                        AppTypography.bodySm.copyWith(color: AppColors.errorText),
                    textAlign: TextAlign.center,
                  ),
                ],

                const SizedBox(height: AppSpacing.lg),

                // Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: AppColors.hairline),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.base),
                      child: Text(
                        'or',
                        style: AppTypography.bodySm
                            .copyWith(color: AppColors.muted),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: AppColors.hairline),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Social login buttons
                SocialLoginButton(
                  label: 'Continue with Google',
                  icon: Icons.g_mobiledata,
                  iconColor: Colors.red,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Google login coming soon')),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                SocialLoginButton(
                  label: 'Continue with Apple',
                  icon: Icons.apple,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Apple login coming soon')),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppTypography.bodyMd
                          .copyWith(color: AppColors.muted),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/register'),
                      child: Text(
                        'Sign up',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.ink,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _extractErrorMessage(Object? error) {
    final errorStr = error.toString();
    if (errorStr.contains('Unauthorized')) {
      return 'Invalid email or password';
    }
    if (errorStr.contains('NetworkException') ||
        errorStr.contains('No internet')) {
      return 'No internet connection. Please try again.';
    }
    return 'Login failed. Please try again.';
  }
}
