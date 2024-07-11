# Gerenciamento de acesso a instâncias SQLServer

### Problematica

Em organizações que utilizam instâncias SQLServer para gerenciar seus bancos de dados, a administração de acessos de usuários é uma tarefa crítica que envolve diversos desafios. Entre os problemas comuns estão:

1. **Controle Inadequado de Permissões**: A falta de um sistema estruturado para conceder e revogar permissões de acesso pode levar a acessos não autorizados, comprometendo a segurança dos dados.
2. **Monitoramento Ineficiente**: Sem um monitoramento adequado, é difícil rastrear quem tem acesso a quais dados e quando essas permissões foram concedidas ou revogadas.
3. **Automação Insuficiente**: A ausência de automação nos processos de gerenciamento de acessos aumenta o risco de erro humano e torna a administração de permissões mais lenta e suscetível a falhas.

Esses problemas podem resultar em vulnerabilidades de segurança, conformidade regulatória inadequada e dificuldades na auditoria de acessos, colocando em risco a integridade e a confidencialidade dos dados corporativos.

### Solução

A documentação fornece uma solução abrangente para esses problemas por meio de uma série de procedimentos que garantem um controle eficiente e seguro dos acessos aos bancos de dados. 

1. **Procedimentos Estruturados**: O manual detalha procedimentos específicos, como o spInserirDadosMonitoramentoUsuario, que garante que todas as permissões de acesso sejam registradas de maneira sistemática na tabela MonitoramentoUsuario. Isso inclui informações como nome do banco de dados, função do banco de dados, usuário, data de concessão da permissão e data de revogação da permissão.

2. **Automação de Revogação de Acesso**: A solução inclui um job automatizado, DBA - RevogarAcesso, que executa diariamente o procedimento spRevogarPermissao. Este procedimento envia notificações por e-mail ao DBA quando permissões de acesso devem ser revogadas, garantindo que os acessos não permaneçam ativos além do necessário.

3. **Monitoramento Contínuo**: O procedimento spMonitoramentoLogin permite um monitoramento contínuo e detalhado dos acessos, retornando informações sobre logins, usuários e funções do banco de dados. Isso facilita a auditoria e assegura que todas as ações de acesso sejam rastreadas e controladas adequadamente.

Ao implementar essa solução, a organização pode garantir um controle e automatização das permissões de acesso, reduzindo significativamente os riscos de segurança associados a acessos não autorizados e melhorando a conformidade com as políticas de segurança e regulamentos aplicáveis.

