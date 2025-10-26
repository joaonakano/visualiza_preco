# Planilha de Casos de Teste de Widget

## Projeto: Visualizador de Preços
**Tipo de Teste:** Widget  
**Responsável:** Equipe de Desenvolvimento  
**Data:** 26/10/2025

---

## TW-01: Teste de Widget AppButton

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TW-01 |
| **Nome do Teste** | Teste de Renderização e Interação do Botão |
| **Objetivo** | Verificar se o componente AppButton é renderizado corretamente e responde adequadamente aos eventos de clique do usuário |
| **Pré-condições** | - Widget AppButton implementado<br>- Flutter test framework configurado |
| **Tipo de Teste** | Widget |
| **Prioridade** | Alta |
| **Dados de Entrada** | **Cenário 1:**<br>- Label: "Clique Aqui"<br>- Callback: função mock<br><br>**Cenário 2:**<br>- Label: "Login"<br>- Callback: função que altera estado<br><br>**Cenário 3:**<br>- Label: "Enviar"<br>- Callback: função vazia |
| **Passos de Execução** | 1. Renderizar o widget AppButton com MaterialApp e Scaffold<br>2. Verificar se o texto do botão é exibido corretamente<br>3. Simular um tap no botão usando tester.tap()<br>4. Verificar se o callback foi executado<br>5. Verificar se o widget é do tipo ElevatedButton |
| **Resultado Esperado** | **Cenário 1:**<br>- Texto "Clique Aqui" encontrado<br>- Callback não executado antes do clique<br><br>**Cenário 2:**<br>- Botão encontrado com texto "Login"<br>- Callback executado após clique<br>- Estado alterado corretamente<br><br>**Cenário 3:**<br>- Widget do tipo ElevatedButton encontrado |
| **Resultado Obtido** | ✅ **PASSOU**<br>- Cenário 1: Texto renderizado ✓, callback não executado ✓<br>- Cenário 2: Callback executado após tap ✓<br>- Cenário 3: ElevatedButton encontrado ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/widget/tw_01_app_button_test.dart` |
| **Widget Testado** | `components/widgets/atoms/app_button.dart` |
| **Observações** | Widget responde corretamente a interações. Renderização visual validada. Evento de clique funciona como esperado. |

---

## TW-02: Teste de Widget AppFormField

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TW-02 |
| **Nome do Teste** | Teste de Campo de Formulário |
| **Objetivo** | Verificar se o componente AppFormField renderiza corretamente, aceita entrada de texto, exibe ícones e valida dados conforme as regras especificadas |
| **Pré-condições** | - Widget AppFormField implementado<br>- TextEditingController configurado<br>- Validadores de formulário implementados |
| **Tipo de Teste** | Widget |
| **Prioridade** | Alta |
| **Dados de Entrada** | **Cenário 1:**<br>- Label: "E-mail"<br>- Icon: Icons.email<br><br>**Cenário 2:**<br>- Label: "Nome"<br>- Texto digitado: "João Silva"<br><br>**Cenário 3:**<br>- Label: "E-mail"<br>- Validador: campo obrigatório<br>- Entrada: vazia<br><br>**Cenário 4:**<br>- Label: "Senha"<br>- isPassword: true |
| **Passos de Execução** | 1. Renderizar AppFormField com diferentes configurações<br>2. Verificar se label e ícone aparecem na tela<br>3. Simular entrada de texto usando enterText()<br>4. Validar se o texto aparece no controller<br>5. Testar validação de formulário<br>6. Verificar campo de senha obscurecido |
| **Resultado Esperado** | **Cenário 1:**<br>- Label "E-mail" exibido<br>- Ícone de email exibido<br><br>**Cenário 2:**<br>- Texto "João Silva" aceito<br>- Controller contém o texto<br><br>**Cenário 3:**<br>- Mensagem "Digite um e-mail válido" exibida<br><br>**Cenário 4:**<br>- Campo renderizado como senha |
| **Resultado Obtido** | ✅ **PASSOU**<br>- Cenário 1: Label e ícone renderizados ✓<br>- Cenário 2: Texto inserido corretamente ✓<br>- Cenário 3: Validação funcionando ✓<br>- Cenário 4: Campo senha obscurecido ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/widget/tw_02_app_form_field_test.dart` |
| **Widget Testado** | `components/widgets/molecules/app_form_field.dart` |
| **Observações** | Widget aceita entrada de texto corretamente. Validação de formulário funcionando. Ícones renderizados. Campo de senha com obscureText funcionando. |

---

## Resumo dos Testes de Widget

| ID | Nome | Status | Arquivo |
|----|------|--------|---------|
| TW-01 | Widget AppButton | ✅ Passou | `test/widget/tw_01_app_button_test.dart` |
| TW-02 | Widget AppFormField | ✅ Passou | `test/widget/tw_02_app_form_field_test.dart` |

**Taxa de Sucesso:** 100% (2/2 testes passaram)

---

## Como Executar

```bash
# Executar todos os testes de widget
flutter test test/widget/

# Executar teste específico
flutter test test/widget/tw_01_app_button_test.dart
flutter test test/widget/tw_02_app_form_field_test.dart
```

## Dependências

- Flutter SDK
- Package: flutter_test
- Widgets testados:
  - `lib/components/widgets/atoms/app_button.dart`
  - `lib/components/widgets/molecules/app_form_field.dart`

## Recursos Utilizados

- **WidgetTester:** Para renderizar e interagir com widgets
- **Finder:** Para localizar widgets na árvore de widgets
- **pump() / pumpAndSettle():** Para processar frames de animação
- **tap():** Para simular toques na tela
- **enterText():** Para simular entrada de texto
