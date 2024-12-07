mkdir test
cd test
git init

echo "f1()" >  example.txt
git add example.txt
git commit -m "1 commit"

echo "f2()" >> example.txt
git add example.txt
git commit -m "2 commit"

echo "f3()" >> example.txt
git add example.txt
git commit -m "3 commit"

echo "f4()" >> example.txt
git add example.txt
git commit -m "4 commit"

echo "f5() & BUG" >> example.txt
git add example.txt
git commit -m "5 commit"

echo "f6()" >> example.txt
git add example.txt
git commit -m "6 commit"

echo "f7()" >> example.txt
git add example.txt
git commit -m "7 commit"

echo "f8()" >> example.txt
git add example.txt
git commit -m "8 commit"

echo "f9()" >> example.txt
git add example.txt
git commit -m "9 commit"

echo "f10()" >> example.txt
git add example.txt
git commit -m "10 commit"
