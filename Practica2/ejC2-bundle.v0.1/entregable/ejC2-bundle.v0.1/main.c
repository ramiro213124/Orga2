#include <stdio.h>
#include <stdlib.h>

#include "stack.h"
#include "student.h"

stack_t *stack;

int main()
{
    stack = createStack(100);

    student_t stud1 = {
        .name = "Steve Balmer",
        .dni = 12345678,
        .califications = {3,2,1},
        .concept = -2,
    };

    studentp_t stud2 = {
        .name = "Linus Torvalds",
        .dni = 23456789,
        .califications = {9,7,8},
        .concept = 1,
    };


    uint32_t *studp;

    // Hint: ver 'createFrame'

    // Push student stud2


    // Push random value
    uint32_t value = 42;
    stack->push(stack,value);

    // Push student stud1



    // Print student st1 y st2

    void (*prStudpt)() = printStudent;
    myCall(stack, prStudpt);

    // A qué apunta el esp???


    prStudpt = printStudentp;
    myCall(stack, prStudpt);


    free(stack); // Alcanza?

    return 0;
}
