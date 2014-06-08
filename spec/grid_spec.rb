require 'grid'
require 'ship'

describe Grid do 

	let(:grid) { Grid.new }
	let(:ship) { Ship.new(2) }
	before(:each) { grid.board[1][2].place_ship!(ship) }

	context 'starts with' do
	
		it 'initializes with at least one row' do
			expect(grid.board.length).to be > 0
		end

		it 'initializes every row having 10 cells' do
			grid.board.each do |row|
				expect(row.length).to eq 10
			end
			#expect(grid.board.all? {|row| row.length == 10}).to eq(true)
		end

	end
	context 'cells can have different states' do

		it 'can just have water' do
			expect(grid.board[0][9]).to have_water
			expect(grid.board[0][9]).not_to have_ship
			expect(grid.board[0][9]).not_to have_been_hit
		end	

		it 'can have hit water' do
			grid.receive_shot(0,9)
			expect(grid.board[0][9]).to have_water
			expect(grid.board[0][9]).to have_been_hit
			expect(grid.board[0][9]).not_to have_ship
		end

		it 'can have ship' do
			expect(grid.board[1][2]).to have_ship
			expect(grid.board[1][2]).not_to have_water
			expect(grid.board[1][2]).not_to have_been_hit
		end

		it 'can have a hit ship' do
			grid.receive_shot(1,2)
			expect(grid.board[1][2]).to have_ship
			expect(grid.board[1][2]).to have_been_hit
			expect(grid.board[1][2]).not_to have_water
		end

		it 'can tell a ship it is hit' do
			expect(ship).to receive(:receive_hit) 
			grid.board[1][2].receive_hit
			# grid.receive_shot(1,2)
		end
	end

	context 'grid can place ships' do

		it 'knows that a ship size equals cell size' do
			expect(grid.ship_number_of_tiles(ship)).to eq ship.size
		end

		# it 'checks whether two coordinates are on the same row, same column, or neither' do
		# 	expect(grid.ship_orientation(0,0,1,0)).to eq :vertical
		# end

		xit 'places a ship either vertically or horizontally (up>down or left>right) on the right no. of tiles' do
			titanic = Ship.new(5)
			grid.place_whole_ship(0, 0, "vertical", titanic)
			expect(grid.board[0][0].occupant.class).to eq Ship
			expect(grid.board[1][0].occupant.class).to eq Ship
			expect(grid.board[2][0].occupant.class).to eq Ship
			expect(grid.board[3][0].occupant.class).to eq Ship
			expect(grid.board[4][0].occupant.class).to eq Ship
		end
	end

	context 'translating coordinates into array indices' do

		it 'knows that A1 is [0][0]' do
			expect(grid.content_in("A","1")).to eq grid.board[0][0]
		end

		it 'knows that C5 is [2][4] ' do
			expect(grid.content_in("C","5")).to eq grid.board[2][4]
		end 
	end
end

# context 'ships cannot occupy the same space' do

		# it 'can have a state of occupied' do
		# 	ship = double :ship
		# 	expect(grid.board[0][0]).to eq ship
		# end


