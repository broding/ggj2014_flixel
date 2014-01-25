package  
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Nerdy Boyz
	 */
	public class Player extends FlxSprite
	{
		[Embed(source="../assets/player.png")] private var ImgPlayer:Class;
		
		private const _maxSpeed:int = 256;
		private const _tileSize:int = GameState.tileSize;
		private var _movementDirection:int = 0;// 0-idle 1-Left 2-Right 3-Up 4-Down
		public var moving:Boolean = false;
		private var _movingDelayPassed:Boolean = true;
		private var _lastIdlePosition:Point;
		private var _timeDelay:Number = 0;
		private var _timedelay:Number = 0;
		private var shadowGroup:FlxGroup;
		private var amountOfShadows:int = 15;
		private var shadowDelay:Number = 0.02;
		private var shadowTimer:Number = 0;
		
		public function Player(X:int, Y:int):void 
		{
			super(X, Y);
			_lastIdlePosition = new Point(X, Y);
			this.loadGraphic(ImgPlayer, false, false, _tileSize, _tileSize);
			shadowGroup = new FlxGroup(amountOfShadows);
			FlxG.state.add(shadowGroup);
			
			for (var i:int = 0; i < amountOfShadows; i++)
			{
				var shadow:PlayerShadow = new PlayerShadow(0, 0, this);
				shadow.kill();
				shadow.visible = false;
				shadowGroup.add(shadow);
			}
		}
		
		override public function update():void
		{
			if (!moving && _movingDelayPassed)
			{
				if (FlxG.keys.LEFT)
				{
					_movementDirection = 1;
					_lastIdlePosition = new Point(this.x, this.y);
					moving = true;
					_movingDelayPassed = false;
				}else if (FlxG.keys.RIGHT)
				{
					_movementDirection = 2;
					_lastIdlePosition = new Point(this.x, this.y);
					moving = true;
					_movingDelayPassed = false;
				}else if (FlxG.keys.UP)
				{
					_movementDirection = 3;
					_lastIdlePosition = new Point(this.x, this.y);
					moving = true;
					_movingDelayPassed = false;
				}else if (FlxG.keys.DOWN)
				{
					_movementDirection = 4;
					_lastIdlePosition = new Point(this.x, this.y);
					moving = true;
					_movingDelayPassed = false;
				}
			}else
			{
				switch(_movementDirection)
				{
					case 0: //idle
						moving = false;
						_timedelay += FlxG.elapsed;
						break;
					case 1: //left
						this.x -= this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.x - _tileSize >= this.x)
						{
							this.x = _lastIdlePosition.x - _tileSize;
							_movementDirection = 0;
						}
						
						break;
					case 2: //right
						this.x += this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.x + _tileSize <= this.x)
						{
							this.x = _lastIdlePosition.x + _tileSize;
							_movementDirection = 0;
						}
						break;
					case 3: //up
						this.y -= this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.y - _tileSize >= this.y)
						{
							this.y = _lastIdlePosition.y - _tileSize;
							_movementDirection = 0;
						}
						break;
					case 4: //down
						this.y += this._maxSpeed * FlxG.elapsed;
						if (_lastIdlePosition.y + _tileSize <= this.y)
						{
							this.y = _lastIdlePosition.y + _tileSize;
							_movementDirection = 0;
						}
						break;
				}
				if (_timedelay >= _timeDelay) {
					if (_movementDirection == 0 && moving == false)
						Score.stepsTaken++;
					_movingDelayPassed = true;
				}
			}
			
			if (_movementDirection != 0)
			{
				shadowTimer += FlxG.elapsed;
				if (shadowTimer >= shadowDelay)
				{
					if (shadowGroup.countDead() > 0)
					{
						var shadow:PlayerShadow = (shadowGroup.getFirstDead() as PlayerShadow);
						shadow.resetShadow(this.x, this.y);
					}
					shadowTimer = 0;
				}
			}else
			{
				shadowTimer = 0;
			}
			
			super.update();
		}
		
		public function HandleCollision():void {
			x = _lastIdlePosition.x;
			y = _lastIdlePosition.y;
			_movementDirection = 0;
			moving = false;
			_movingDelayPassed = true;
		}
	}

}