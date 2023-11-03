package io.burt.jmespath;

/**
 * This enum represents the six value types defined in the JMESPath specification.
 */
public enum JmesPathType {
  NUMBER,
  STRING,
  BOOLEAN,
  ARRAY,
  OBJECT,
  NULL,
  DATE;

  @Override
  public String toString() {
    return name().toLowerCase();
  }
}
