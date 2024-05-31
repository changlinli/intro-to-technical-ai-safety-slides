# What is optimization?

+ Optimization generally entails taking a function and finding its extremal
  values (i.e. minimum or maximum values)
    * E.g. optimizing the quadratic function $f(x) = x^2$
    * Usually, but not always, when we optimize in machine learning we are
      finding the minimum of a function
+ Machine learning is all about optimization!
+ But what are we actually optimizing?

# What are we actually optimizing

Question for everyone, what is the function we are actually optimizing when
training a vanilla neural net that does image recognition on handwritten digits?

+ Is it the function that takes an image and outputs a number between 0
  and 9?
    * No. The minimum of that function are all images that output 0. It's not
      clear how that gives us a well-trained neural net.
+ Is it the function that takes an image and outputs an $R^10$ vector
  with one component for each possible digit?
    * No. It's not clear what it even means to take the minimum of a vector in
      $R^n$. Which is smaller, $(-10, -7)$ or $(-8, -9)$? Generally you need
      some way of tranforming your $R^n$ vector to a single $R$ (e.g. calculate its
      length). Also even if you had a way of defining minimums you'd still have
      the same problem.
+ Is it the function that takes and image and outputs the training loss
  associated with that image?
    * No. The minimum of that function is the image that the current network can
      most accurately recognize at the moment. It's not clear how to use that
      information to train our network to be better at recognizing digits for
      that image, let alone other images.

# What are we actually optimizing

+ We are optimizing the function from the network weights to the loss for a
  fixed training set
+ For a fixed single image, we can calculate the loss of our network for that
  fixed image, relative to the weights of our network
    * The minimum of that function is the weights of our network that give us
      the minimum loss for that image, i.e. the network that is the most
      accurate recognizer for that single image
+ For a batch of $n$ images, the above gives us a function from images to $R^n$
+ This seems bad given what we said earlier about how confusing it is to
  calculate $R^n$ for images
+ Question for audience: How can we reduce that $R^n$ to $R$?

# Thinking about constants and variables

+ A big chunk of machine learning involves taking the same thing and just
  changing what we consider to be constants and what we consider to be variables
    * At inference time, we think of our image recognition network as a function
      from images to $R^10$ (i.e. the images are variables) and hold our weights as constant
    * At training time, we fix our training set of images to be constant and
      think of our network as a function from network weights to loss
+ Quite a few machine learning techniques boil down "reframe what you consider
  to be constants and what you consider variables and then optimize based on
  that new set of variables"

# Double-check understanding

+ Many ML libraries only calculate the gradient of a function, i.e. the
  derivative of a scalar-valued function (function outputs are scalars) instead
  of the Jacobian of a function, i.e. the derivative of a fully
  multi-dimensional $R^m \to R^n$ function. Why?

# So how do we actually find the optimum?

+ Recap: the function we are optimizing is network weights to total loss of
  training set, so our function's minimum is those weights which give us the
  minimum total loss across the training set
+ But how do we actually find the minimum?
+ Gradient descent!
    * Only finds local minima
    * Only finding local minima instead of the global minimum is the source of
      the overwhelming majority of problems in AI and AI safety!

# Vanilla gradient descent (SGD)

+ Calculate the gradient and then adjust by some multiple of that gradient
  (called "learning rate")
+ Stochastic gradient descent, while technically another term referring to the
  size of the training batch you use, is generally used in PyTorch to refer to
  vanilla gradient descent

# Problems with SGD

+ Can be very slow on "plateaus"
    * If you try to fix this by increasing learning rate can easily "overshoot"
      optima
    * Would be better to adapt update size based on estimates of whether we're
      in a plateau or not
+ Can get stuck very easily in local optima

# SGD with momentum

+ Keep track of the average gradient you have seen so far
    * Time-decayed (exponential decay) average
    * Up to some scaling constant
+ Add that average to your current gradient

# RMSProp

+ Keep track of the standard deviation (away from 0) of the gradient you have seen so far
    * Note away from 0 (i.e. uncentered standard deviation)
    * Also time-decayed (exponential decay)
    * Also up to some scaling constant
+ Penalize by that standard deviation
    * Divide by deviation
    * High deviation from 0 reduces gradient update, low deviation from 0
      increases gradient update

# Adam

+ Do both!
+ Keep track of (time-decayed and scaled) average and add to gradient
+ Penalize by (time-decayed and scaled) standard deviation away from 0 of gradient
+ Add "weight decay" term (not true weight decay as we'll see later with AdamW)

# Regularization

+ Refers to a big bag of techniques used to try to combat overfitting
+ Focus on one sub-class for now: try to reduce the magnitude of network weights
    * High network weights suggest
+ L1 regularization: Add a penalty for the sum of absolute values of weight
+ L2 regularization: Add a penalty for the sum of values of weights squared
+ Weight decay: after every iteration of gradient descent, directly shrink all
  weights by a certain constant

# L2 regularization vs weight decay

+ L2 regularization is the same thing as weight decay for SGD
    * Update amount for L2 regularization: $- \nabla (f(\theta_t) + \lamda \sum \theta_t ^2) = - \nabla f(\theta_t) - 2 * \lambda \sum \theta_t$
    * Update amount for weight decay: $- \nabla f(\theta_t) - \lambda \sum \theta_t$
    * Just rescale $\lambda$ and the two are the same
+ L2 regularization is not the same thing as weight decay when you introduce
  momentum!

# AdamW

+ Original Adam paper seemd to not realize that weight decay is not the
  same thing as L2 regularization for certain optimizers (Kingma and Ba makes reference to "L2 weight decay")
    * As a result most Adam implementations use L2 regularization but
      incorrectly call it weight decay
+ AdamW paper shows that the two are different and offers some arguments why
  weight decay is preferable to L2 regularization
+ In practice this means changing where you multiply by your weight decay
  parameter

# Why does all this help?

+ A lot of guesses (some quite sophisticated)
+ But no real rigorous answers
+ One example of the increasing amount of hand-waving you'll see in ML/AI
