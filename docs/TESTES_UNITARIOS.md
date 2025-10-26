# Planilha de Casos de Teste Unitários

## Projeto: Visualizador de Preços
**Tipo de Teste:** Unitário  
**Responsável:** Equipe de Desenvolvimento  
**Data:** 26/10/2025

---

## TU-01: Teste de Cálculo de Desconto

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TU-01 |
| **Nome do Teste** | Teste de Cálculo de Desconto em Preço |
| **Objetivo** | Verificar se a função de cálculo de desconto retorna o valor correto após aplicar o percentual de desconto ao preço original |
| **Pré-condições** | - Classe PriceCalculator implementada<br>- Método calculateDiscount disponível |
| **Tipo de Teste** | Unitário |
| **Prioridade** | Alta |
| **Dados de Entrada** | **Cenário 1:**<br>- Preço Original: 100.0<br>- Desconto: 10%<br><br>**Cenário 2:**<br>- Preço Original: 200.0<br>- Desconto: 50%<br><br>**Cenário 3:**<br>- Preço Original: -10.0<br>- Desconto: 10%<br><br>**Cenário 4:**<br>- Preço Original: 100.0<br>- Desconto: 150% |
| **Passos de Execução** | 1. Importar a classe PriceCalculator<br>2. Chamar o método calculateDiscount com os valores de teste<br>3. Comparar o resultado com o valor esperado<br>4. Verificar tratamento de exceções para valores inválidos |
| **Resultado Esperado** | **Cenário 1:** Retorna 90.0<br>**Cenário 2:** Retorna 100.0<br>**Cenário 3:** Lança ArgumentError<br>**Cenário 4:** Lança ArgumentError |
| **Resultado Obtido** | ✅ **PASSOU**<br>- Cenário 1: 90.0 ✓<br>- Cenário 2: 100.0 ✓<br>- Cenário 3: ArgumentError lançado ✓<br>- Cenário 4: ArgumentError lançado ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/unit/tu_01_price_calculator_test.dart` |
| **Método Testado** | `PriceCalculator.calculateDiscount(double, double)` |
| **Observações** | Teste cobre casos válidos e inválidos. Validação de entrada implementada corretamente. |

---

## TU-02: Teste de Formatação de Preço

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TU-02 |
| **Nome do Teste** | Teste de Formatação de Valor Monetário |
| **Objetivo** | Verificar se a função de formatação converte valores numéricos para o padrão monetário brasileiro (R$ X,XX) corretamente |
| **Pré-condições** | - Classe PriceCalculator implementada<br>- Método formatPrice disponível<br>- Método calculateTotal disponível |
| **Tipo de Teste** | Unitário |
| **Prioridade** | Alta |
| **Dados de Entrada** | **Cenário 1:**<br>- Valor: 100.0<br><br>**Cenário 2:**<br>- Valor: 49.99<br><br>**Cenário 3:**<br>- Valor: 0.50<br><br>**Cenário 4:**<br>- Lista de preços: []<br><br>**Cenário 5:**<br>- Lista de preços: [10.0, 20.0, 30.0] |
| **Passos de Execução** | 1. Importar a classe PriceCalculator<br>2. Chamar o método formatPrice com valores de teste<br>3. Verificar se o formato retornado está correto (R$ X,XX)<br>4. Chamar calculateTotal com diferentes listas<br>5. Verificar se a soma está correta |
| **Resultado Esperado** | **Cenário 1:** "R$ 100,00"<br>**Cenário 2:** "R$ 49,99"<br>**Cenário 3:** "R$ 0,50"<br>**Cenário 4:** 0.0<br>**Cenário 5:** 60.0 |
| **Resultado Obtido** | ✅ **PASSOU**<br>- Cenário 1: "R$ 100,00" ✓<br>- Cenário 2: "R$ 49,99" ✓<br>- Cenário 3: "R$ 0,50" ✓<br>- Cenário 4: 0.0 ✓<br>- Cenário 5: 60.0 ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/unit/tu_02_price_formatting_test.dart` |
| **Método Testado** | `PriceCalculator.formatPrice(double)`<br>`PriceCalculator.calculateTotal(List<double>)` |
| **Observações** | Formatação segue padrão brasileiro. Função de cálculo de total também testada. Cobre casos extremos (lista vazia, valores pequenos). |

---

## Resumo dos Testes Unitários

| ID | Nome | Status | Arquivo |
|----|------|--------|---------|
| TU-01 | Cálculo de Desconto | ✅ Passou | `test/unit/tu_01_price_calculator_test.dart` |
| TU-02 | Formatação de Preço | ✅ Passou | `test/unit/tu_02_price_formatting_test.dart` |

**Taxa de Sucesso:** 100% (2/2 testes passaram)

---

## Como Executar

```bash
# Executar todos os testes unitários
flutter test test/unit/

# Executar teste específico
flutter test test/unit/tu_01_price_calculator_test.dart
flutter test test/unit/tu_02_price_formatting_test.dart
```

## Dependências

- Flutter SDK
- Package: flutter_test
- Classe: `lib/utils/price_calculator.dart`
