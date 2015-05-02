require 'rspec'
require 'towers_of_hanoi'

describe TowersOfHanoi do
  let(:towers) { [[3,2,1,0],[],[]] }
  let(:game) { TowersOfHanoi.new }

  context "Initialization" do
    it "should initialize 3 arrays, one with disks" do
      expect(game.towers).to eq(towers)
    end
  end

  context "correct player action - move to empty tower" do
    before(:each) do
      game.move_disk(0,1)
    end

    it "(towers) should be correctly updated" do
      expect(game.towers).to eq([[3,2,1],[0],[]])
    end
  end

  context "correct player action - move smaller disk on to larger disk" do
    before(:each) do
      game.move_disk(0,2)
      game.move_disk(0,1)
      game.move_disk(2,1)
    end

    it "(towers) should be correctly updated" do
      expect(game.towers).to eq([[3,2],[1,0],[]])
    end
  end

  context "incorrect player action - move larger disk on to smaller disk" do
    before(:each) do
      game.move_disk(0,1)
    end

    it "should raise an error" do
      expect { game.move_disk(0,1) }.to raise_error(RuntimeError)
    end

    it "(towers) should not change" do
      expect(game.towers).to eq([[3,2,1],[0],[]])
    end
  end

  describe "incorrect player actions" do
    context "when player takes disk from an empty tower" do
      it "should raise an error" do
        expect { game.move_disk(1,0) }.to raise_error(RuntimeError)
      end

      it "(towers) should not change" do
        expect(game.towers).to eq(towers)
      end
    end

    context "when player moves to an nonexistent tower" do
      it "should raise an error" do
        expect { game.move_disk(0, 5) }.to raise_error(RuntimeError)
      end
    end
  end

  context "When player wins" do
    describe "#wins?" do
      before(:each) do
        game.towers = [[],[3,2,1,0],[]]
      end

      it "should return true when start tower is empty and another tower is full" do
        expect(game.wins?).to eq(true)
      end
    end
  end
end







    context
