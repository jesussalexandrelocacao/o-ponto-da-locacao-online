# O Ponto da Locação online

## Opção recomendada: Supabase + site estático

1. Crie um projeto no Supabase.
2. No Supabase, abra `SQL Editor` e execute `supabase/schema.sql`.
3. Em `Authentication > Users`, crie o usuário que acessará o sistema.
4. Em `Project Settings > API`, copie:
   - Project URL
   - anon public key
5. Abra o sistema, vá em `ACESSO ONLINE`, cole a URL e a chave anon, informe e-mail/senha e clique em `Entrar`.
6. Clique em `Enviar dados para a nuvem` na primeira sincronização.

Depois disso, o app continua salvando localmente e tenta enviar alterações para a nuvem quando há login ativo.

## Publicação do site

Publique a pasta do projeto como site estático em Netlify, Vercel, GitHub Pages ou hospedagem comum. Os arquivos mínimos são:

- `index.html`
- `assets/logo-o-ponto-da-locacao.jpg`
- `assets/logo-data.js`

Não publique arquivos de teste em `tmp/` se não precisar deles.

## Segurança no GitHub

Se uma versão com cadastros reais já foi enviada para um repositório público, apagar ou substituir o arquivo atual não remove o histórico. O caminho mais seguro é excluir o repositório antigo e criar outro repositório público usando a versão limpa em `publicar-online`, ou tornar o repositório privado.

A versão limpa não traz cadastros reais no `index.html`. Os dados devem ficar apenas no Supabase, protegidos por login e pelas políticas RLS do arquivo `supabase/schema.sql`.
