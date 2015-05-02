require 'rspec'
require 'array'

describe Array do

  describe "#my_uniq" do
    subject(:array) { [2, 2, 1] }

    context "when given an empty array" do
      it "should return an empty array" do
        expect([].my_uniq).to eq([])
      end
    end

    context "when given a uniq array" do
      let(:uniq_array) { [1, 2, 3] }
      it "should return itself" do
        expect(uniq_array.my_uniq).to  eq(uniq_array)
      end
    end

    context "when given an array with duplicates" do
      it "should return a unique array" do
        expect(array.my_uniq).to eq([2, 1])
      end
    end
  end

  describe "#two_sum" do
    context "when given an empty array" do
      it "should return an empty array" do
        expect([].two_sum).to eq([])
      end
    end

    context "when given an array with no pair sums" do
      let(:no_pairs) {[1,3,2]}
      it "should return an empty array" do
        expect(no_pairs.two_sum).to eq([])
      end
    end

    context "when given an array with one pair sum" do
      let(:one_pair) {[1,-1]}
      it "should return indices of pair" do
        expect(one_pair.two_sum).to eq([[0,1]])
      end
    end

    context "when given multiple pair sums" do
      let(:many_pairs) {[1,-1,2,-2,-1]}
      it "should return indices of pairs in order of smaller element" do
        expect(many_pairs.two_sum).to eq([[0,1],[0,4],[2,3]])
      end
      # let(:jumbled_pairs) {[-1,0,2,-2,1]}
      # it "should return smaller elements first" do
      #   expect()
    end
  end

  describe "#my_transpose" do
    let(:rows) do
      [[0, 1, 2],
       [3, 4, 5],
       [6, 7, 8]]
    end


    context "when not given a matrix" do
      it "should raise an error" do
        expect { [].my_transpose }.to raise_error(ArgumentError)
      end
    end

    context "when matrix is not square" do
      let(:non_square) { rows[0..1] }

      it "should raise an error when matrix is empty" do
        expect { [[]].my_transpose }.to raise_error(ArgumentError)
      end

      it "should raise an error when matrix is not empty" do
        expect { non_square.my_transpose }.to raise_error(ArgumentError)
      end
    end

    context "when matrix is square" do
      let(:transposed) do
        [[0, 3, 6],
         [1, 4, 7],
         [2, 5, 8]]
      end
      it "should return transposed matrix" do
        expect(rows.my_transpose).to eq(transposed)
      end
    end
  end
end
