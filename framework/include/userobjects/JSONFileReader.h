//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "GeneralUserObject.h"

/**
 * User object that reads a JSON file and makes its data available to other objects
 */
class JSONFileReader : public GeneralUserObject
{
public:
  static InputParameters validParams();

  JSONFileReader(const InputParameters & parameters);

  /// Required implementation of a pure virtual function (not used)
  virtual void initialize() override{};

  /// Required implementation of a pure virtual function (not used)
  virtual void finalize() override{};

  /// Read the file again
  virtual void execute() override { read(_filename); };

  /// Getters for scalar values
  void getScalar(const std::string & scalar_name, Real & scalar) const;
  /// Getter for vector values
  void getVector(const std::string & vector_name, std::vector<Real> & vector) const;

private:
  /**
   * Read the JSON file and load it into _root
   * @param filename the name of the file
   */
  void read(const FileName filename);

  /**
   * Get a real number from a node and handle potential type conversions needed
   * @param node a node from the JSON tree
   * @return the real number desired
   */
  Real getReal(const nlohmann::json & node) const;

  /// Database filename
  const FileName _filename;
  /// JSON data
  nlohmann::json _root;
};
