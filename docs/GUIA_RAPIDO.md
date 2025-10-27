

### Executar TODOS os 6 testes
```powershell
flutter test
```

### Por tipo de teste
```powershell
# Unitários (TU-01, TU-02)
flutter test test/unit/

# Widget (TW-01, TW-02)
flutter test test/widget/

# Integração (TI-01, TI-02)
flutter test test/integration/
```

## Checklist de Validação

- [ ] **Executar:** `flutter test`
- [ ] **Verificar:** Todos os testes passaram ✓
- [ ] **Confirmar:** 23+ testes executados
- [ ] **Validar:** Mensagem "All tests passed!"

##  Arquivos de Entrega

### Código-Fonte (6 arquivos)
```
 test/unit/tu_01_price_calculator_test.dart
 test/unit/tu_02_price_formatting_test.dart
 test/widget/tw_01_app_button_test.dart
 test/widget/tw_02_app_form_field_test.dart
 test/integration/ti_01_login_flow_test.dart
 test/integration/ti_02_api_service_test.dart
```



## Resumo dos Casos de Teste
 ID  Tipo  Nome  Status 

 TU-01 | Unitário | Cálculo de Desconto 
 TU-02 | Unitário | Formatação de Preço 
TW-01 | Widget | AppButton 
 TW-02 | Widget | AppFormField 
 TI-01 | Integração | Fluxo de Login 
 TI-02 | Integração | Serviço de API 

**Total: 6/6 testes**


## Apresentação

Para demonstração ao professor:

```powershell
# 1. Mostre a estrutura
ls test/

# 2. Execute todos os testes
flutter test --reporter expanded

# 3. Execute um teste específico
flutter test test/unit/tu_01_price_calculator_test.dart
```


