class ShoeModelMapper
  def translator(string)
    raise 'empty string' if string.empty?
    string[1..-1].split(',').map do |h|  # previous version -> string.delete('#') instead of string[-1..1]
      h1, h2 = h.split(':')
      { h1 => h2 }
    end.reduce(:merge)
  end
end


RSpec.describe ShoeModelMapper do
  let(:string) { ShoeModelMapper.new }

  it 'tranlate correct string to hash' do
    expect(string.translator('#s:2,z:6,c:1')).to eq('s' => '2', 'z' => '6', 'c' => '1')
  end

  it 'tranlate empty string' do
    expect { string.translator('') }.to raise_error(RuntimeError)
  end

  it 'tranlate incorrect string to hash' do
    expect(string.translator('#foo')).to eq('foo' => nil)
  end

  it 'tranlate incorrect string to hash' do
    expect(string.translator('#foo:2:4')).to eq('foo' => '2')
  end

  it 'raise error when invalid number of arguments' do
    expect { string.translator }.to raise_error(ArgumentError)
  end
end
