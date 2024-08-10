---
title: AI on Rails
version: 1.0.0
theme: dracula
footer: "@arandilopez"
paginate: true
marp: true
---
<div id="slide-title">

# AI on Rails

Mejorando busquedas y recomendaciones con PostgreSQL.

</div>

<style scoped>
#slide-title {
    display: flex;
    flex-direction: column;
    align-content: center;
    justify-content: center;
    height: 100%;
}
</style>

---

# Preparar el proyecto

```bash
rails new ai-on-rails -d postgresql -a propshaft --css=tailwind
```

Puedes encontrar el projecto en Github: https://github.com/arandilopez/ai-on-rails

---

# Instalar PgVector

```dockerfile
# postgres.Dockerfile

FROM postgres:latest

RUN apt-get update && apt-get install -y build-essential git postgresql-server-dev-all \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/pgvector/pgvector.git

WORKDIR /tmp/pgvector
RUN make
RUN make install
```

---

# Instalar PgVector

```bash
rails generate migration create_vector_extension
```

```ruby
class InstallPgvectorExtension < ActiveRecord::Migration[7.1]
  def up
    create_extension 'vector'
  end

  def down
    drop_extension 'vector'
  end
end
```
