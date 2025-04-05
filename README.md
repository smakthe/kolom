# কলম Language

কলম (Kolom) is a toy scripting language that uses Bengali keywords instead of English. It's implemented as a Ruby gem and compiles to Ruby, leveraging Ruby's powerful metaprogramming capabilities.

## Installation

```bash
gem install kolom
```

Or add this line to your application's Gemfile:

```ruby
gem 'kolom'
```

And then execute:

```bash
bundle install
```

## Usage

### Running কলম Programs

You can run a কলম script file:

```bash
kolom path/to/your/script.kl
```

Or execute কলম code directly:

```bash
kolom -e 'লেখো "নমস্কার বিশ্ব!"'
```

### Using the REPL

You can start an interactive REPL:

```bash
kolom
```

### Example Program

Here's a simple example of a কলম program:

```
# Define a class
শ্রেণী ব্যক্তি
  সংজ্ঞা শুরু(নাম, বয়স)
    @নাম = নাম
    @বয়স = বয়স
  শেষ

  সংজ্ঞা পরিচয়_দাও
    লেখো("আমার নাম #{@নাম} এবং আমার বয়স #{@বয়স} বছর।")
  শেষ
শ্রেণী

# Create an instance
আমি = ব্যক্তি.নতুন("করিম", 30)
আমি.পরিচয়_দাও
```

## Keywords and Methods

কলম provides Bengali equivalents for common Ruby keywords and methods:

### Keywords

| Kolom | Ruby |
|---------|------|
| শ্রেণী | class |
| সংজ্ঞা | def |
| যদি | if |
| নইলে | else |
| তাহলে | then |
| কর | do |
| জন্য | for |
| যখন | when |
| ও | and |
| বা | or |
| না | not |
| সত্য | true |
| মিথ্যা | false |
| ফেরত | return |

### Methods

| Kolom | Ruby |
|---------|------|
| লেখো | print |
| দৈর্ঘ্য | length |
| সংযোগ | concat |
| বিভাগ | split |
| নিবেশ | push |
| নিরসন | pop |
| সম্বদ্ধ | join |
| প্রয়োগ | map |
| প্রত্যেক | each |
| আকার | size |

## Features

- Translation of Bengali keywords to Ruby equivalents
- Support for core Ruby types (String, Array, Hash)
- Dynamic method handling using metaprogramming
- Interactive REPL with command history
- Support for file-based scripts
- Error handling and debugging

## Advanced Features

- Dynamic method definition
- Method aliasing in Bengali
- Method tracing for debugging
- DSL support
- Lazy evaluation using Fiber
- Concurrent execution with Threads

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the MIT License.