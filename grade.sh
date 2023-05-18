CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


#testing
#check files
if [[ -f "student-submission/ListExamples.java" ]]
then
    echo "files submitted correctly"
else 
    echo "files submitted incorrectly"
    exit 1
fi

#copy files to grading-area
cp -r student-submission/ TestListExamples.java grading-area

#compile tests
javac grading-area/*/ListExamples.java  -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt 2>&1
echo `pwd`
output=`cat test_output.txt`
num_failures=$(echo "$output" | grep -oP 'Failures:"\K\d+' | tail -1)
echo "Number: $num_failures"

if [[ $? != 0 ]]
then
    failureCount = $(echo test-output.txt | grep -oP 'Failures: "\K\d+' | tail -1)
    echo "$failureCount"
    echo "JUNIT Test failure"
    exit 1
else
    echo "Correct"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
