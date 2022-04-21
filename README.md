# Analisador de sentimento

Este app usa o Azure Cognitive Service for Language para analizar o sentimento
de uma frase enviada pelo usuário através da caixa de texto.

## Instruções de uso

Para executar o programa, realize os seguintes passos:

1. [Crie um serviço do tipo Language do Azure Cognitive Services](https://portal.azure.com/#create/Microsoft.CognitiveServicesTextAnalytics);
2. No arquivo `lib/ui/sentiment_ui.dart`, na linha 16, insira a subscription
key do serviço Azure;


![Subscription Key aqui](/doc/sub_key.png)


3. Execute o comando `flutter pub get` para baixar as dependências;
4. Execute o comando `flutter run -d chrome --web-renderer html` para executar
o programa;
5. Digite um texto na caixa de texto e utilize o botão abaixo para escolher a
linguagem entre inglês e português;


![Tela do programa](/doc/screenshot.png)


6. Clique em "Analisar" e veja o resultado!
