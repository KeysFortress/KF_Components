import 'package:components/auto_fill_component/auto_fill_component_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AutoFillComponent extends StatelessWidget {
  const AutoFillComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AutoFillComponentViewModel(context),
      builder: (context, viewModel, child) => AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: viewModel.usernameController,
              autofillHints: [AutofillHints.username],
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: viewModel.passwordConroller,
              autofillHints: [AutofillHints.password],
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: viewModel.onLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
