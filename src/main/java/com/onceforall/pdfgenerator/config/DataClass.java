package com.onceforall.pdfgenerator.config;

import java.lang.annotation.*;

/**
 * This annotation allows to document data classes.
 *
 * Since DTOs are only composed of fields and accessors, there is no need for encapsulation.
 * Properties then could be public in order to simplify their writing.
 *
 */
@Retention(RetentionPolicy.SOURCE)
@Target(ElementType.TYPE)
@Documented
public @interface DataClass {
}
