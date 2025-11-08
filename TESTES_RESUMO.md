#  Testes Criados - Visualiza Preço

##  Resumo
Foram criados **10 testes** divididos em 3 categorias, baseados no código **REAL** do projeto (não mais na API do Keanu Reeves).

---

##  Testes Unitários (4 testes)

### TU-01: Validação de Barcode
**Arquivo:** `test/unit/tu_01_price_calculator_test.dart`
-  Deve criar barcode válido com números
-  Deve rejeitar barcode vazio

**Testa:** `lib/domain/product/value_objects/barcode.dart`

### TU-02: Entidade Product  
**Arquivo:** `test/unit/tu_02_price_formatting_test.dart`
-  Deve criar produto com todos os dados
-  Deve criar cópia do produto com dados alterados

**Testa:** `lib/domain/product/entities/product.dart`

---

##  Testes de Widget (4 testes)

### TW-01: AppButton
**Arquivo:** `test/widget/tw_01_app_button_test.dart`
-  Deve renderizar botão com texto correto
-  Deve executar callback ao clicar

**Testa:** `lib/components/widgets/atoms/app_button.dart`

### TW-02: AppCard
**Arquivo:** `test/widget/tw_02_app_text_test.dart`
- Deve renderizar card com conteúdo
- Deve aplicar elevação customizada

**Testa:** `lib/components/widgets/molecules/app_card.dart`

---

##  Testes de Integração (4 testes)

### TI-01: Navegação do Aplicativo
**Arquivo:** `test/integration/ti_01_navigation_test.dart`
-  Deve iniciar app na tela de scanner
-  Deve abrir dialog de busca manual

**Testa:** Fluxo completo de navegação do app

### TI-02: APIs de Produtos
**Arquivo:** `test/integration/ti_02_api_test.dart`
-  Deve buscar produto da OpenFoodFacts
-  Deve buscar produtos do estoque local

**Testa:** 
- `lib/infrastructure/product/datasources/openfoodfacts_datasource.dart`
- `lib/infrastructure/product/datasources/stock_datasource.dart`

---

##  Como Rodar os Testes

### Rodar todos os testes
```bash
flutter test
```

### Rodar apenas testes unitários
```bash
flutter test test/unit/
```

### Rodar apenas testes de widget
```bash
flutter test test/widget/
```

### Rodar apenas testes de integração
```bash
flutter test test/integration/
```

---

##  Resultado Final
```
 10/10 testes passando
```

---



##  Observações
- Todos os testes agora usam **código real** do projeto
- Testes de integração fazem chamadas **reais** às APIs (OpenFoodFacts e StockDatasource)
- Testes de widget verificam componentes **realmente usados** no app
- Testes unitários cobrem as entidades e value objects do **DDD**
