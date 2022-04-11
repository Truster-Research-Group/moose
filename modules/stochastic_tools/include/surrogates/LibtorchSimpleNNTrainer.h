//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#ifdef TORCH_ENABLED
#include <torch/torch.h>
#include "LibtorchSimpleNeuralNet.h"
#endif

#include "libmesh/utility.h"
#include "SurrogateTrainer.h"

class LibtorchSimpleNNTrainer : public SurrogateTrainer
{
public:
  static InputParameters validParams();

  LibtorchSimpleNNTrainer(const InputParameters & parameters);

  virtual void preTrain() override;

  virtual void train() override;

  virtual void postTrain() override;

private:
  /// Data from the current sampler row
  const std::vector<Real> & _sampler_row;

  /// Response value
  const Real & _response;

  /// The gathered data in a flattened form to be able to convert easily to torch::Tensor.
  std::vector<Real> _flattened_data;

  /// The gathered response in a flattened form to be able to convert easily to torch::Tensor.
  std::vector<Real> _flattened_response;

  /// Number of batches we want to prepare
  const unsigned int _num_batches;

  /// Number of epochs for the training
  const unsigned int _num_epocs;

  /// Number of neurons within the hidden layers (the length of this vector
  /// should be the same as _num_hidden_layers)
  std::vector<unsigned int> & _num_neurons_per_layer;

  /// Number of hidden layers in the neural net
  unsigned int & _num_hidden_layers;

  /// Name of the pytorch output file. This is used for loading and storing
  /// already existing data.
  const std::string _filename;

  /// Switch indicating if an already existing neural net should be read from a
  /// file or not. This can be used to load existing torch files (from previous
  /// MOOSE or python runs for retraining and further manipulation)
  const bool _read_from_file;

  /// The learning rate for the optimization algorithm
  const Real _learning_rate;

  /// Print the training loss value every given epoch
  const unsigned int _print_epoch_loss;

#ifdef TORCH_ENABLED
  /// Pointer to the neural net object (initialized as null)
  std::shared_ptr<StochasticTools::LibtorchSimpleNeuralNet> & _nn;
#endif
};
