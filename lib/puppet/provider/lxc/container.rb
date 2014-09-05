Puppet::Type.type(:lxc).provide(:container) do

  defaultfor :operatingsystem => :ubuntu
  confine :feature => :lxc, :kernel => 'Linux'

  def create
    c = LXC::Container.new(resource[:name])
    c.create(resource[:template], resource[:storage_backend].to_s, symbolize_hash(resource[:storage_options]))

    case resource[:state]
    when :running
      self.start
    when :frozen
      self.start
      self.frozen
    end

  end

  def exists?
    LXC::Container.new(resource[:name]).defined?
  end

  def destroy

    case self.status
    when :running
      self.stop
    when :frozen
      self.unfreeze
      self.stop
    end

    LXC::Container.new(resource[:name]).destroy
  end

  def start
    c = LXC::Container.new(resource[:name])

    if self.status == :frozen
      self.unfreeze
    else
      c.start
    end

    c.wait(:running, @resource[:timeout])
  end

  def stop
    c = LXC::Container.new(resource[:name])
    c.stop
    c.wait(:stopped, @resource[:timeout])
  end

  def freeze
    c = LXC::Container.new(resource[:name])
    c.freeze
    c.wait(:frozen, @resource[:timeout])
  end

  def unfreeze
    c = LXC::Container.new(resource[:name])
    c.unfreeze
    c.wait(:running, @resource[:timeout])
  end

  def status
    LXC::Container.new(resource[:name]).state
  end

  private
  def symbolize_hash hash
    result = {}
    if hash.nil?
      return nil
    else
      hash.each do |k,v|
        if v.kind_of?Hash
          result[k.to_sym] = self.symbolize_hash v
        else
          result[k.to_sym] = k == 'fssize' ? v.to_i : v
        end
      end
    end
    result
  end
end
