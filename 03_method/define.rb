# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること

class A1
  def initialize
    A1.define
  end

  def self.define
    define_method("//") do
      "//"
    end
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
class A2
  def initialize(params)
    A2.define_hoge_method(params)
  end

  def self.define_hoge_method(params)
    return if params.empty?
    params.each do |param|
      define_method("hoge_#{param}") do |count|
        return dev_team unless count
        str = ''
        count.times do
          str += "hoge_#{param}"
        end
        str
      end
    end
  end

  def dev_team
    "SmartHR Dev Team"
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること
module OriginalAccessor
  def self.included(base)
    base.define_singleton_method :my_attr_accessor do |name|
      define_method name do
        instance_variable_get("@#{name}")
      end

      define_method "#{name}=" do |value|
        instance_variable_set("@#{name}", value)

        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          define_singleton_method("#{name}?") do
            value
          end
        end
      end
    end
  end
end
