/*
 * [TestHexLiterals.java]
 *
 * Summary: Demonstrate how to use hex literals in Java.
 *
 * Copyright: (c) 2013-2016 Roedy Green, Canadian Mind Products, http://mindprod.com
 *
 * Licence: This software may be copied and used freely for any purpose but military.
 *          http://mindprod.com/contact/nonmil.html
 *
 * Requires: JDK 1.8+
 *
 * Created with: JetBrains IntelliJ IDEA IDE http://www.jetbrains.com/idea/
 *
 * Version History:
 *  1.0 2013-01-05 initial version.
 */
package com.mindprod.example;

import static java.lang.System.*;

/**
 * Demonstrate how to use hex literals in Java.
 *
 * @author Roedy Green, Canadian Mind Products
 * @version 1.0 2013-01-05 initial version.
 * @since 2013-01-05
 */
public final class TestHexLiterals
    {
    /**
     * Test harness
     *
     * @param args not used
     */
    public static void main( String[] args )
        {
        byte b = ( byte ) 0x20;
        char c = '\u00c9';
        short s = ( short ) 0x0fab;
        int i = 0xffab;
        long l = 0xffabL;
        float f = 0x1.0abcdefp3F;  // p3 means times 8 i.e. 2 to the power 3
        double d = 0x1.0abcdefp3D;
        out.println( b + " " + c + " " + s + " " + i + " " + l + " " + f + " " + d );
        // displays 32 É 4011 65451 65451 8.335555 8.335555523633957
        }
    }
