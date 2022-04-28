<?php

declare(strict_types=1);

namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use Doctrine\ORM\OptimisticLockException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\ConstraintViolationInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class ProductController extends AbstractController
{
    public function __construct(private ProductRepository $productRepository)
    {
    }

    #[Route('/product', name: 'all_product', methods: ['GET'])]
    public function index(): Response
    {
        return $this->json($this->productRepository->findBy(['household' => $this->getUser()->getHousehold()]));
    }

    #[Route('/product/{id<\d+>}', name: 'one_product', methods: ['GET'])]
    public function get(int $id): Response
    {
        $product = $this->productRepository->findOneBy(['household' => $this->getUser()->getHousehold(), 'id' => $id]);

        if (is_null($product) === true) {
            throw new NotFoundHttpException();
        }

        return $this->json($product);
    }

    #[Route('/product', name: 'create_product', methods: ['POST'])]
    public function create(Request $request, ValidatorInterface $validator): Response
    {
        $requestBody = json_decode($request->getContent(), true);

        $product = (new Product())
            ->setName($requestBody['name'] ?? '')
            ->setHousehold($this->getUser()->getHousehold())
            ->setDescription($requestBody['description'] ?? '')
            ->setImage(null)
            ->setType($requestBody['type'] ?? '');


        $errors = $validator->validate($product);

        if (count($errors) !== 0) {
            $displayErrors = [];

            /** @var ConstraintViolationInterface $error */
            foreach ($errors as $error) {
                $displayErrors[$error->getPropertyPath()][] = $error->getMessage();
            }

            return $this->json(['error' => $displayErrors], Response::HTTP_BAD_REQUEST);
        }

        try {
            $this->productRepository->add($product);
        } catch (OptimisticLockException $e) {
            return $this->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->json(['id' => $product->getId()], Response::HTTP_CREATED);
    }

    #[Route('/product/{id<\d+>}', name: 'update_product', methods: ['PATCH'])]
    public function update(Request $request, ValidatorInterface $validator, int $id): Response
    {
        $requestBody = json_decode($request->getContent(), true);

        $product = $this->productRepository->findOneBy(['household' => $this->getUser()->getHousehold(), 'id' => $id]);

        if (is_null($product) === true) {
            throw new NotFoundHttpException();
        }

        $product
            ->setName($requestBody['name'] ?? $product->getName())
            ->setDescription($requestBody['description'] ?? $product->getDescription())
            ->setType($requestBody['type'] ?? $product->getType());

        $errors = $validator->validate($product);

        if (count($errors) !== 0) {
            $displayErrors = [];

            /** @var ConstraintViolationInterface $error */
            foreach ($errors as $error) {
                $displayErrors[$error->getPropertyPath()][] = $error->getMessage();
            }

            return $this->json(['error' => $displayErrors], Response::HTTP_BAD_REQUEST);
        }

        try {
            $this->productRepository->add($product);
        } catch (OptimisticLockException $e) {
            return $this->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->json(['id' => $product->getId()], Response::HTTP_ACCEPTED);
    }

    #[Route('/product/{id<\d+>}', name: 'delete_product', methods: ['DELETE'])]
    public function delete(int $id): Response
    {
        $product = $this->productRepository->findOneBy(['household' => $this->getUser()->getHousehold(), 'id' => $id]);

        if (is_null($product) === true) {
            throw new NotFoundHttpException();
        }

        try {
            $this->productRepository->remove($product);
        } catch (OptimisticLockException $e) {
            return $this->json(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
        }

        return $this->json(['id' => $id], Response::HTTP_ACCEPTED);
    }
}
