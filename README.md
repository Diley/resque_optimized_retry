# ResqueOptimizedRetry

Um problema que sempre tive ao trabalhar com sistema grande onde tem muita conexão com o Redis é na hora de dar retry nos jobs que falharam. Normalmente perde-se jobs e/ou gera muita slowquery. Com slowquery fica tudo que utiliza o Redis muito lento, inclusive o retry e a execução dos outros jobs. Com essa gem você irá cosneguir dar retry e clear nos seus jobs que falharam sem perder nenhum job e gerando o mínimo de slowquery possível (É sempre bom lembrar que as slowquery dependem muito de como seu sistema utiliza o Redis, por isso não tem como afirmar com 100% de certeza que não vai haver nenhuma slowquery ao executar retry e/ou clear).

Em um teste realizado com 345k de jobs falhados obteve 2 slowquery, demorou cerca de 8 minutos e não perdeu nenhum job.
Em um novo teste realizado com 56k de jobs utilizando a gem resque-cleaner obteve 20k+ slowquery, demorou mais de 1 hora e não perdeu nenhum job.

## Installation

Add this line to your application's Gemfile:

    gem 'resque_optimized_retry'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resque_optimized_retry

## Usage

### Retry and Clear

```ruby
ResqueOptimizedRetry::Jobs.new.retry_and_clear
```

### Retry

```ruby
ResqueOptimizedRetry::Jobs.new.retry
```

### Clear

```ruby
ResqueOptimizedRetry::Jobs.new.clear
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request