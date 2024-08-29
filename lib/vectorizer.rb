class Vectorizer
  MODEL = 'mxbai-embed-large'.freeze
  OLLAMA_ADDRESS = ENV.fetch('OLLAMA_ADDRESS', 'http://host.docker.internal:11434').freeze

  def initialize
    @ollama = Ollama.new(
      credentials: { address: OLLAMA_ADDRESS },
      options: { server_sent_events: true }
    )
  end

  def vectorize(text)
    result = ollama.embeddings({
                                 model: MODEL,
                                 prompt: text,
                                 options: {
                                   num_ctx: 8192
                                 }
                               })

    result.first['embedding']
  end

  private

  attr_reader :ollama
end
