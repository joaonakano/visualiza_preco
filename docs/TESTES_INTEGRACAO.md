# Planilha de Casos de Teste de Integração

## Projeto: Visualizador de Preços
**Tipo de Teste:** Integração  
**Responsável:** Equipe de Desenvolvimento  
**Data:** 26/10/2025

---

## TI-01: Teste de Integração - Fluxo de Login

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TI-01 |
| **Nome do Teste** | Teste de Fluxo Completo de Login |
| **Objetivo** | Validar o fluxo completo de autenticação do usuário, desde o preenchimento do formulário até a navegação para a tela principal após login bem-sucedido |
| **Pré-condições** | - Aplicação compilada e executável<br>- Tela de login implementada<br>- Validações de formulário configuradas<br>- Navegação entre telas funcional |
| **Tipo de Teste** | Integração |
| **Prioridade** | Crítica |
| **Componentes Integrados** | - LoginScreen<br>- AppFormField (múltiplas instâncias)<br>- AppButton<br>- Validadores de formulário<br>- Sistema de navegação Flutter<br>- NewDashBoard (tela destino) |
| **Dados de Entrada** | **Cenário 1 - Login Válido:**<br>- Nome: "João Silva"<br>- E-mail: "joao@example.com"<br>- Senha: "123456"<br><br>**Cenário 2 - E-mail Inválido:**<br>- Nome: "Maria Santos"<br>- E-mail: "emailinvalido"<br>- Senha: "123456"<br><br>**Cenário 3 - Senha Curta:**<br>- Nome: "Pedro Alves"<br>- E-mail: "pedro@example.com"<br>- Senha: "123" |
| **Passos de Execução** | **Para todos os cenários:**<br>1. Iniciar a aplicação com MyApp()<br>2. Aguardar renderização completa (pumpAndSettle)<br>3. Verificar se está na tela de login<br>4. Localizar campos de formulário (nome, email, senha)<br>5. Preencher campos com dados de teste<br>6. Verificar se os valores foram inseridos<br>7. Localizar e clicar no botão "Login"<br>8. Processar frames de animação<br>9. Verificar resultado esperado |
| **Resultado Esperado** | **Cenário 1:**<br>- Todos os campos preenchidos ✓<br>- Validação passa ✓<br>- Navegação para tela principal ✓<br>- Texto "Consulta Preço Login" não aparece mais<br><br>**Cenário 2:**<br>- Mensagem "Digite um e-mail válido" exibida<br>- Navegação NÃO ocorre<br>- Usuário permanece na tela de login<br><br>**Cenário 3:**<br>- Mensagem "A senha deve conter ao menos 6 caracteres." exibida<br>- Navegação NÃO ocorre<br>- Usuário permanece na tela de login |
| **Resultado Obtido** | ✅ **PASSOU**<br>**Cenário 1:**<br>- Formulário preenchido ✓<br>- Navegação bem-sucedida ✓<br>- Mudança de tela confirmada ✓<br><br>**Cenário 2:**<br>- Erro de validação exibido ✓<br>- Login bloqueado ✓<br><br>**Cenário 3:**<br>- Erro de validação exibido ✓<br>- Login bloqueado ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/integration/ti_01_login_flow_test.dart` |
| **Fluxo Testado** | Login completo: Formulário → Validação → Navegação |
| **Observações** | Fluxo completo funcionando. Validações de e-mail e senha operando corretamente. Navegação ocorre apenas com dados válidos. Experiência do usuário validada end-to-end. |

---

## TI-02: Teste de Integração - Serviço de API

| **Campo** | **Descrição** |
|-----------|---------------|
| **ID do Caso de Teste** | TI-02 |
| **Nome do Teste** | Teste de Integração com API Externa |
| **Objetivo** | Validar a integração completa com a API Keanu Whoa, incluindo requisição HTTP, deserialização JSON, criação de objetos de modelo e validação de dados recebidos |
| **Pré-condições** | - Conexão com internet ativa<br>- API https://whoa.onrender.com disponível<br>- KeanuService implementado<br>- Models (Quote, Video) implementados<br>- Package http configurado |
| **Tipo de Teste** | Integração |
| **Prioridade** | Alta |
| **Componentes Integrados** | - KeanuService<br>- HTTP Client (package http)<br>- Quote Model<br>- Video Model<br>- QuotesList<br>- JSON Decoder<br>- API Externa (Whoa API) |
| **Dados de Entrada** | **Cenário 1:**<br>- Quantidade de quotes: 3<br><br>**Cenário 2:**<br>- Quantidade de quotes: 1<br><br>**Cenário 3:**<br>- Quantidade de quotes: 5<br><br>**Cenário 4:**<br>- Teste de conversão toString() |
| **Passos de Execução** | **Cenário 1:**<br>1. Instanciar KeanuService<br>2. Chamar fetchQuotes(3)<br>3. Aguardar resposta assíncrona<br>4. Verificar quantidade de quotes retornadas<br>5. Validar campos obrigatórios de cada quote<br><br>**Cenário 2:**<br>1. Buscar 1 quote<br>2. Extrair objeto Video<br>3. Validar URLs de vídeo em todas as qualidades<br><br>**Cenário 3:**<br>1. Buscar 5 quotes<br>2. Validar estrutura completa de dados<br>3. Verificar relação currentWhoa ≤ totalWhoas<br><br>**Cenário 4:**<br>1. Buscar quote<br>2. Chamar toString()<br>3. Verificar formato de saída |
| **Resultado Esperado** | **Cenário 1:**<br>- 3 quotes retornadas<br>- Campos movie, character, fullLine preenchidos<br>- year > 0<br><br>**Cenário 2:**<br>- URLs de vídeo não vazias<br>- fullhd, hd, mediumLow, low preenchidos<br>- URLs começam com "http"<br><br>**Cenário 3:**<br>- 5 quotes retornadas<br>- Todos os campos não nulos<br>- year, currentWhoa, totalWhoas positivos<br>- currentWhoaInMovie ≤ totalWhoasInMovie<br>- Objeto video presente<br>- poster não vazio<br><br>**Cenário 4:**<br>- String contém "Quote("<br>- Contém "movie:" e "year:"<br>- Contém nome do filme |
| **Resultado Obtido** | ✅ **PASSOU**<br>**Cenário 1:**<br>- Requisição HTTP bem-sucedida ✓<br>- 3 quotes deserializadas ✓<br>- Campos obrigatórios validados ✓<br><br>**Cenário 2:**<br>- Objeto Video processado ✓<br>- 4 qualidades de vídeo presentes ✓<br>- URLs válidas ✓<br><br>**Cenário 3:**<br>- Estrutura completa validada ✓<br>- Regras de negócio verificadas ✓<br><br>**Cenário 4:**<br>- toString() formatado corretamente ✓ |
| **Status** | ✅ Aprovado |
| **Arquivo de Teste** | `test/integration/ti_02_api_service_test.dart` |
| **Fluxo Testado** | Requisição API → Deserialização → Validação de Dados |
| **Observações** | Integração com API funcionando perfeitamente. Deserialização JSON correta. Models bem estruturados. Validação de dados robusta. Teste depende de conexão com internet e disponibilidade da API externa. |

---

## Resumo dos Testes de Integração

| ID | Nome | Status | Arquivo |
|----|------|--------|---------|
| TI-01 | Fluxo de Login | ✅ Passou | `test/integration/ti_01_login_flow_test.dart` |
| TI-02 | Serviço de API | ✅ Passou | `test/integration/ti_02_api_service_test.dart` |

**Taxa de Sucesso:** 100% (2/2 testes passaram)

---

## Como Executar

```bash
# Executar todos os testes de integração
flutter test test/integration/

# Executar teste específico
flutter test test/integration/ti_01_login_flow_test.dart
flutter test test/integration/ti_02_api_service_test.dart

# Executar com mais detalhes
flutter test test/integration/ --reporter expanded
```

## Dependências

- Flutter SDK
- Package: flutter_test
- Package: http
- Conexão com internet (para TI-02)
- Componentes testados:
  - `lib/main.dart`
  - `lib/pages/user/login_screen.dart`
  - `lib/services/keanu_service.dart`
  - `lib/models/keanu_quotes_model.dart`

## Recursos Utilizados

- **Testes Assíncronos:** async/await para requisições HTTP
- **WidgetTester:** Para simular interações completas do usuário
- **HTTP Mocking:** (Opcional - pode ser implementado futuramente)
- **Integration Testing:** Validação de múltiplos componentes trabalhando juntos

## Observações Importantes

1. **TI-02 requer internet:** O teste de API faz requisições reais à API externa
2. **Tempo de execução:** Testes de integração podem levar mais tempo devido a requisições de rede
3. **Cobertura:** Os testes cobrem fluxos críticos da aplicação
