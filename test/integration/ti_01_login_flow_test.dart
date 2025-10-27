import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visualizador_de_precos/main.dart';

/// TI-01: Teste de Integração - Fluxo de Login
/// Verifica o fluxo completo de preenchimento e submissão do formulário de login
void main() {
  group('TI-01 - Teste de Integração: Fluxo de Login', () {
    testWidgets('Deve completar fluxo de login com sucesso', (
      WidgetTester tester,
    ) async {
      // Arrange (Preparação)
      const String nomeUsuario = 'João Silva';
      const String emailUsuario = 'joao@example.com';
      const String senhaUsuario = '123456';

      // Act (Execução) - Inicia o app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Assert - Verifica se está na tela de login
      expect(find.text('Login'), findsWidgets);

      // Act - Preenche o campo Nome
      final Finder campoNome = find.byType(TextFormField).at(0);
      await tester.enterText(campoNome, nomeUsuario);
      await tester.pump();

      // Act - Preenche o campo E-mail
      final Finder campoEmail = find.byType(TextFormField).at(1);
      await tester.enterText(campoEmail, emailUsuario);
      await tester.pump();

      // Act - Preenche o campo Senha
      final Finder campoSenha = find.byType(TextFormField).at(2);
      await tester.enterText(campoSenha, senhaUsuario);
      await tester.pump();

      // Assert - Verifica se os valores foram inseridos
      expect(find.text(nomeUsuario), findsOneWidget);
      expect(find.text(emailUsuario), findsOneWidget);

      // Act - Scroll para garantir que o botão está visível e clica
      await tester.ensureVisible(find.text('Login').last);
      await tester.tap(find.text('Login').last);
      await tester.pumpAndSettle();

      // Assert - Verifica se houve navegação (se a tela mudou)
      
      expect(find.byType(TextFormField), findsNothing);
    });

    testWidgets('Deve exibir erro ao tentar login com e-mail inválido', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String nomeUsuario = 'Maria Santos';
      const String emailInvalido = 'emailinvalido'; 
      const String senhaUsuario = '123456';

      // Act - Inicia o app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Preenche os campos
      await tester.enterText(find.byType(TextFormField).at(0), nomeUsuario);
      await tester.enterText(find.byType(TextFormField).at(1), emailInvalido);
      await tester.enterText(find.byType(TextFormField).at(2), senhaUsuario);
      await tester.pump();

      // Act - Scroll e tenta fazer login
      await tester.ensureVisible(find.text('Login').last);
      await tester.tap(find.text('Login').last);
      await tester.pumpAndSettle();

      // Assert - Verifica que ainda está na tela de login (navegação não ocorreu)
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('Deve exibir erro ao tentar login com senha curta', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String nomeUsuario = 'Pedro Alves';
      const String emailUsuario = 'pedro@example.com';
      const String senhaCurta = '123'; 

      // Act - Inicia o app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act - Preenche os campos
      await tester.enterText(find.byType(TextFormField).at(0), nomeUsuario);
      await tester.enterText(find.byType(TextFormField).at(1), emailUsuario);
      await tester.enterText(find.byType(TextFormField).at(2), senhaCurta);
      await tester.pump();

      // Act - Scroll e tenta fazer login
      await tester.ensureVisible(find.text('Login').last);
      await tester.tap(find.text('Login').last);
      await tester.pumpAndSettle();

      // Assert - Verifica que ainda está na tela de login (navegação não ocorreu)
      expect(find.byType(TextFormField), findsWidgets);
    });
  });
}
