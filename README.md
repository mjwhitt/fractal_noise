# fractal_noise

simple ruby script for generating images of 2D fractal noise using Perlin noise or value noise

**Installation**

1. git clone git@github.com:mjwhitt/fractal_noise.git
2. cd fractal_noise/
3. bundle install --path vendor/

**Example Output**

> ./bin/fractal_noise -a value -s 1138 -w 256 -h 256 -n

![value-1138.png](value-1138.png)

> ./bin/fractal_noise -a perlin -s 1138 -w 256 -h 256 -n

![perlin-1138.png](perlin-1138.png)

**See Also**

* [Value Noise](http://www.spacedust.info/2014/06/value-noise/)
* [Value Noise - Extras](http://www.spacedust.info/2014/07/value-noise-extras/)
* [Value Noise - Tiled](http://www.spacedust.info/2014/08/value-noise-tiled/)
