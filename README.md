# AI on Rails

This is a POC project that integrates text embedding and stores the vectors in Postgres with the PgVector plugi and perfoms similarity searches using the Neighbors gem.

### Dependencies

- Ruby 3.3.4
- Rails 7.2
- Docker
- [Devpod](https://devpod.sh/) (optional)
- Postgres 16 with [pgvector](https://github.com/pgvector/pgvector)
- [Ollama](https://ollama.com/)
    - [Gemma2](https://ai.google.dev/gemma#gemma-2)
    - [mxbai-embed-large-v1](https://www.mixedbread.ai/blog/mxbai-embed-large-v1)

### Data Ownership

This project downloaded drugs information from [Drugs.com](https://www.drugs.com/).

## Installation

Clone or fork the repo

```bash
git clone https://github.com/arandilopez/ai-on-rails.git
```

Start the devcontainer in VsCode or run the following command if you have **Devpod** installed

```bash
devpod up .
```

Install the dependencies

```bash
bundle install
```

Create the database

```bash
rails db:create
```

Run the migrations

```bash
rails db:migrate
```

Seed the database

```bash
rails db:seed
```

Start the server

```bash
bin/dev
```

## Data scraping

To scrape the data from Drugs.com run the following command

```bash
rake drugs:scrap_urls
```

Then scrap the drugs information

```bash
rake drugs:scrap_content
```

To get a markdown formatted description of the drugs run

```bash
rake drugs:convert_to_markdown
```

This will be a slow process, so be patient.

After that you can generate the embeddings

```bash
rake drugs:generate_embeddings
```
