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

1. Clone or fork the repo

```bash
git clone https://github.com/arandilopez/ai-on-rails.git
```

2. Start the devcontainer in VsCode or run the following command if you have **Devpod** installed

```bash
devpod up .
```

3. Install the dependencies

```bash
bundle install
```

4. Create the database

```bash
rails db:create
```

5. Run the migrations

```bash
rails db:migrate
```

6. Seed the database, this will populate the database with the drugs information

```bash
rails db:seed
```

7. Start the server

```bash
bin/dev
```

### Start Ollama models

1. Install Ollama from the [download page](https://ollama.com/download)
2. Pull the models

```bash
ollama pull mxbai-embed-large-v1
```

```bash
ollama pull gemma2
```

3. Start the Ollama server

```bash
ollama server
```

## Data scraping (optional)

1. To scrape the data from Drugs.com run the following command

```bash
rake drugs:scrap_urls
```

2. Then scrap the drugs information

```bash
rake drugs:scrap_content
```

3. To get a markdown formatted description of the drugs run

```bash
rake drugs:convert_to_markdown
```

This will be a slow process, so be patient.

## Generate embeddings

Maker sure you have the Ollama server running and the models downloaded. Then run the following command

```bash
rake drugs:generate_embeddings
```
