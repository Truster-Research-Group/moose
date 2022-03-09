//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "SurrogateTrainer.h"
#include "Standardizer.h"
#include <Eigen/Dense>

#include "Distribution.h"

#include "CovarianceFunctionBase.h"
#include "CovarianceInterface.h"

#include "GaussianProcessUtils.h"

class GaussianProcessTrainer : public SurrogateTrainer, public CovarianceInterface
{
public:
  static InputParameters validParams();
  GaussianProcessTrainer(const InputParameters & parameters);
  virtual void preTrain() override;
  virtual void train() override;
  virtual void postTrain() override;

  // Routine to perform hyperparameter tuning
  PetscErrorCode hyperparamTuning();

  PetscErrorCode FormInitialGuess(GaussianProcessTrainer * GP_ptr, Vec theta);

  // Wrapper for PETSc function callback
  static PetscErrorCode
  FormFunctionGradientWrapper(Tao tao, Vec theta, PetscReal * f, Vec Grad, void * ptr);

  // Computes Gradient of the loss function
  void FormFunctionGradient(Tao tao, Vec theta, PetscReal * f, Vec Grad);

  // Sets bounds for hyperparameters
  void buildHyperParamBounds(libMesh::PetscVector<Number> & theta_l,
                             libMesh::PetscVector<Number> & theta_u) const;
  // write stored hyperparam_vecs to PetscVec
  void mapToVec(libMesh::PetscVector<Number> & theta) const;

  // loads PetscVec to stored hyperparam_vecs
  void vecToMap(libMesh::PetscVector<Number> & theta);

  StochasticTools::GaussianProcessUtils & getGPUtils() { return _gp_utils; }

private:
  StochasticTools::GaussianProcessUtils & _gp_utils;

  /// Paramaters (x) used for training, along with statistics
  RealEigenMatrix & _training_params;

  /// Switch for training param (x) standardization
  bool _standardize_params;

  /// Switch for training data(y) standardization
  bool _standardize_data;

  /// Flag to toggle hyperparameter tuning/optimization
  bool _do_tuning;

  /// Command line options to feed to TAO optimization
  std::string _tao_options;

  /// Flag to toggle printing of TAO output
  bool _show_tao;

  /// Tao Communicator
  Parallel::Communicator _tao_comm;

  /// Contains tuning inforation. Index of hyperparam, size, and min/max bounds
  std::unordered_map<std::string, std::tuple<unsigned int, unsigned int, Real, Real>> _tuning_data;

  /// Number of tunable hyperparameters
  unsigned int _num_tunable;

  /// Scalar hyperparameters. Stored for use in surrogate
  std::unordered_map<std::string, Real> & _hyperparam_map;

  /// Vector hyperparameters. Stored for use in surrogate
  std::unordered_map<std::string, std::vector<Real>> & _hyperparam_vec_map;

  /// Data from the current sampler row
  const std::vector<Real> & _sampler_row;

  /// Response value
  const Real & _rval;

  /// Predictor values from reporters
  std::vector<const Real *> _pvals;

  /// Columns from sampler for predictors
  std::vector<unsigned int> _pcols;

  /// Total number of parameters/dimensions
  unsigned int _n_params;

  /// Data (y) used for training
  RealEigenMatrix _training_data;
};
