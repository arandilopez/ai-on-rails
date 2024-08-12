class Vectorizer
  MODEL = "mxbai-embed-large".freeze

  def initialize
    @ollama = Ollama.new(
      credentials: { address: ENV.fetch(
        "OLLAMA_ADDRESS", "http://host.docker.internal:11434"
      ), },
      options: { server_sent_events: true }
    )
  end

  def vectorize(text)
    prompt = <<~PROMPT
      Represent this drug description text for searching relevant information:
      #{text}
    PROMPT

    result = ollama.embeddings({
                                 model: MODEL,
                                 prompt: prompt
                               })

    result.first["embedding"]
  end

  private

  attr_reader :ollama
end
