function t -d "tsc "

tsc --strict --target ES6 $argv[1].ts --outFile $argv[1].js; node $argv[1]-es6.js

end 