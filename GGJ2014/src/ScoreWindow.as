package
{
	import org.flixel.*;

	
	
	public class ScoreWindow extends FlxGroup
	{
		private const WIDTH:int = 400;
		private const HEIGHT:int = 300;
		
		private var _bg:FlxSprite;
		private var _title:FlxText;
		private var _levelScoreText:FlxText;
		private var _totalScoreText:FlxText;
		
		private var _continueText:FlxText;
		
		private var _particles:FlxGroup;
		
		private var _particleTimer:Number;
		
		private var _levelScore:int;
		private var _totalScore:int;
		
		private var _callback:Function;
		
		public function ScoreWindow(levelScore:int, callback:Function)
		{
			_callback = callback;
			
			_levelScore = levelScore;
			_totalScore = 310;
			
			_particles = new FlxGroup();
			_particleTimer = 0;
			
			for(var i:int = 0; i < 30; i++)
			{
				var particle:ScoreParticle = new ScoreParticle();
				particle.scrollFactor.make(0,0);
				particle.makeGraphic(10, 10, 0xff111111);
				particle.x = FlxG.width / 2 + (Math.random() * 60 - 30);
				particle.y = 259;
				particle.kill();
				_particles.add(particle);
			}
			
			_bg = new FlxSprite();
			_bg.makeGraphic(WIDTH, HEIGHT, 0xddffffff);
			_bg.x = FlxG.width / 2 - WIDTH / 2;
			_bg.y = FlxG.height / 2 - HEIGHT / 2;
			_bg.scrollFactor.make(0,0);
			
			_title = new FlxText(0, 0, FlxG.width, "Score this level:");
			_title.y = 180;
			_title.scrollFactor.make(0,0);
			_title.setFormat("AldotheApache", 24, 0x333333);
			_title.alignment = "center";
			
			_levelScoreText = new FlxText(0, 0, FlxG.width, "1260");
			_levelScoreText.y = 220;
			_levelScoreText.scrollFactor.make(0,0);
			_levelScoreText.setFormat("AldotheApache", 40, 0x111111);
			_levelScoreText.alignment = "center";
			
			_totalScoreText = new FlxText(0, 0, FlxG.width, "4217");
			_totalScoreText.y = 300;
			_totalScoreText.scrollFactor.make(0,0);
			_totalScoreText.setFormat("AldotheApache", 72, 0x111111);
			_totalScoreText.alignment = "center";
			
			_continueText = new FlxText(0, 0, FlxG.width, "Press SPACE to continue");
			_continueText.y = 400;
			_continueText.scrollFactor.make(0,0);
			_continueText.setFormat("AldotheApache", 16, 0x555555);
			_continueText.alignment = "center";
			
			add(_bg);
			add(_title);
			add(_particles);
			add(_levelScoreText);
			add(_totalScoreText);
			add(_continueText);
		}
		
		override public function update():void
		{
			super.update();
			
			if(_levelScore > 0)
			{
				_particleTimer += FlxG.elapsed;
				
				if(_particleTimer > Math.random())
				{
					var particle:FlxSprite = _particles.getFirstDead() as FlxSprite;
					particle.revive();
					particle.velocity.y = 200;
					_particleTimer = 0;
				}
				
				_levelScore -= 5;
				_totalScore += 5;
				
				_totalScoreText.text = _totalScore.toString();
				_levelScoreText.text = _levelScore.toString();
			}
			else
			{
				_particles.clear();
				
				if(FlxG.keys.justPressed("SPACE"))
					_callback();
			}
			
		}
	}
}